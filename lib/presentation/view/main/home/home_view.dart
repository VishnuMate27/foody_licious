import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/core/router/tab_navigator.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_usecase.dart';
import 'package:foody_licious/presentation/bloc/menuItem/menu_item_bloc.dart';
import 'package:foody_licious/presentation/cubit/pagination/pagination_cubit.dart';
import 'package:foody_licious/presentation/widgets/menu_item_card.dart';
import 'package:foody_licious/presentation/widgets/search_bar_field.dart';
import 'package:foody_licious/presentation/view/product/menu_item_details_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../notification/notification_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  final int _pageSize = 10;
  late final PaginationCubit _paginationCubit;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _paginationCubit = PaginationCubit();

    // Initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuItemBloc>().add(
            GetAllItemsInRestaurantsOfUsersCity(
              GetAllItemsInRestaurantsOfUsersCityParams(
                  page: 1, limit: _pageSize),
            ),
          );
    });

    // Scroll Listener for pagination
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final pstate = _paginationCubit.state;

        if (!pstate.isLoadingMore && pstate.hasMoreItems) {
          _paginationCubit.loadMoreItems();

          context.read<MenuItemBloc>().add(
                GetAllItemsInRestaurantsOfUsersCity(
                  GetAllItemsInRestaurantsOfUsersCityParams(
                    page: _paginationCubit.state.currentPage,
                    limit: _pageSize,
                  ),
                ),
              );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _paginationCubit,
      child: Scaffold(
        backgroundColor: kWhite,
        body: BlocConsumer<MenuItemBloc, MenuItemState>(
          listener: (context, state) {
            if (state is FetchingAllMenuItemsSuccess) {
              final newItems = state.menuItems;
              final hasMore = (newItems.length % _pageSize == 0);
              _paginationCubit.setHasMoreItems(hasMore);
            }
          },
          builder: (context, state) {
            if (state is FetchingAllMenuItemsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is FetchingAllMenuItemsFailed) {
              return const Center(child: Text("Failed to load items"));
            }

            if (state is FetchingAllMenuItemsSuccess) {
              final items = state.menuItems;

              return ListView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 40.h),
                children: [
                  // HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Explore Your Favorite Food",
                        style:
                            GoogleFonts.yeonSung(color: kTextRed, fontSize: 24),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationView(),
                            ),
                          );
                        },
                        icon: Icon(
                          CupertinoIcons.bell,
                          size: 24,
                          color: kGreen,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 18.h),

                  // SEARCH
                  SearchBarField(searchController: _searchController),

                  SizedBox(height: 20.h),

                  // CAROUSEL
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 172.h,
                      autoPlay: true,
                      viewportFraction: 0.85,
                      enlargeCenterPage: true,
                    ),
                    items: [kBanner1, kBanner2, kBanner3].map((img) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          image: DecorationImage(
                            image: AssetImage(img),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 20.h),

                  // POPULAR LABEL
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular",
                          style: GoogleFonts.yeonSung(
                            color: kTextRed,
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "View More",
                            style: GoogleFonts.lato(
                              color: kTextRed,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // MENU ITEM LIST
                  ...List.generate(items.length, (index) {
                    final menuItem = items[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: MenuItemCard(
                          itemImageUrl: (menuItem.images?.isNotEmpty ?? false)
                              ? menuItem.images!.first
                              : "https://img.freepik.com/free-psd/hand-drawn-burger-illustration_23-2151600206.jpg",
                          itemName: menuItem.name,
                          hotelName:
                              menuItem.restaurantName ?? menuItem.restaurantId,
                          itemPrice: menuItem.price,
                          onTap: () => TabNavigator.pushMenuItemDetails(
                              context, menuItem)),
                    );
                  }),

                  // BOTTOM LOADER
                  BlocBuilder<PaginationCubit, PaginationState>(
                    builder: (context, pState) {
                      if (pState.isLoadingMore) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  SizedBox(height: 12.h),
                ],
              );
            }
            print("-state is $state");
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
