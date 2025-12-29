import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/router/tab_navigator.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_in_restaurant_usecase.dart';
import 'package:foody_licious/domain/usecase/restaurant/get_restaurant_details_usecase.dart';
import 'package:foody_licious/presentation/bloc/menuItem/menu_item_bloc.dart';
import 'package:foody_licious/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:foody_licious/presentation/cubit/pagination/pagination_cubit.dart';
import 'package:foody_licious/presentation/view/product/menu_item_details_view.dart';
import 'package:foody_licious/presentation/widgets/menu_item_card.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantDetailsView extends StatefulWidget {
  final String restaurantId;
  const RestaurantDetailsView({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailsView> createState() => _RestaurantDetailsViewState();
}

class _RestaurantDetailsViewState extends State<RestaurantDetailsView> {
  List<bool> isItemCheckedList = List<bool>.generate(15, (index) => false);
  final ScrollController _scrollController = ScrollController();
  static const int _itemsPerPage = 10;

  @override
  void initState() {
    if (widget.restaurantId != '' || widget.restaurantId.isNotEmpty) {
      context.read<RestaurantBloc>().add(FetchRestaurantDetails(
          GetRestaurantDetailsParams(widget.restaurantId)));
    }
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      final paginationState = context.read<PaginationCubit>().state;
      if (paginationState.hasMoreItems && !paginationState.isLoadingMore) {
        context.read<PaginationCubit>().loadMoreItems();
        final nextPage = paginationState.currentPage + 1;
        context.read<MenuItemBloc>().add(
              GetMenuItemsInRestaurant(
                GetAllMenuItemsInRestaurantParams(
                  restaurantId: widget.restaurantId,
                  page: nextPage,
                  limit: _itemsPerPage,
                ),
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantBloc, RestaurantState>(
        listener: (context, state) {
      if (state is RestaurantDetailsFetchSuccess) {
        if (widget.restaurantId != '' || widget.restaurantId.isNotEmpty) {
          // Reset pagination when fetching new restaurant details
          context.read<PaginationCubit>().reset();
          context.read<MenuItemBloc>().add(
                GetMenuItemsInRestaurant(
                  GetAllMenuItemsInRestaurantParams(
                    restaurantId: widget.restaurantId,
                    page: 1,
                    limit: _itemsPerPage,
                  ),
                ),
              );
        }
      }
    }, listenWhen: (previous, current) {
      return (current is RestaurantDetailsFetchSuccess);
    }, builder: (context, state) {
      if (state is FetchingRestaurantDetails) {
        return CircularProgressIndicator();
      } else if (state is RestaurantDetailsFetchSuccess) {
        return Scaffold(
          backgroundColor: kWhite,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(kBackArrowIcon),
            ),
            automaticallyImplyLeading: true,
          ),
          body: BlocBuilder<MenuItemBloc, MenuItemState>(
              builder: (context, menuState) {
            if (menuState is FetchingAllMenuItemsInRestaurantLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (menuState is FetchingAllMenuItemsInRestaurantSuccess) {
              return BlocBuilder<PaginationCubit, PaginationState>(
                builder: (context, paginationState) {
                  return ListView.builder(
                    controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    itemCount: menuState.menuItems.length +
                        4 + // +4 for restaurant details section
                        (paginationState.isLoadingMore ? 1 : 0),
                    itemBuilder: (BuildContext context, int index) {
                      // Restaurant details header section
                      if (index == 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                state.restaurant.name ?? "Restaurant Name",
                                style: GoogleFonts.yeonSung(
                                    color: kTextRed, fontSize: 28),
                              ),
                            ),
                            SizedBox(height: 26.h),
                            Center(
                              child: Image.network(
                                state.restaurant.photoUrl ?? kRestraurantImage,
                                height: 200.h,
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Text(
                              "Short description",
                              style: GoogleFonts.yeonSung(
                                  color: kBlack, fontSize: 20),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              state.restaurant.description ??
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad",
                              style: GoogleFonts.lato(
                                  color: kBlack,
                                  fontSize: 14,
                                  letterSpacing: 0.5),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Menu",
                              style: GoogleFonts.yeonSung(
                                  color: kBlack, fontSize: 20),
                            ),
                            SizedBox(height: 6.h),
                          ],
                        );
                      }

                      // Menu loading indicator
                      if (index < 4) {
                        return SizedBox.shrink();
                      }

                      // Show loading indicator at the end
                      if (index ==
                          menuState.menuItems.length +
                              4 +
                              (paginationState.isLoadingMore ? 0 : 1)) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final menuItemIndex = index - 4;
                      if (menuItemIndex < 0 ||
                          menuItemIndex >= menuState.menuItems.length) {
                        return SizedBox.shrink();
                      }

                      final menuItem = menuState.menuItems[menuItemIndex];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: MenuItemCard.retraurantMenuItem(
                          itemImageUrl: kMenuPhoto1,
                          itemName: menuItem.name,
                          hotelName:
                              menuItem.restaurantName ?? "Restaurant Name",
                          itemPrice: menuItem.price,
                          isInitiallyChecked: false,
                          onTap: () {},
                          onSeeDetailsPressed: () {
                            // TODO: Add menu item in MenuItemDetailsView
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MenuItemDetailsView(menuItem: menuItem),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<MenuItemBloc>().add(
                          GetMenuItemsInRestaurant(
                            GetAllMenuItemsInRestaurantParams(
                              restaurantId: widget.restaurantId,
                              page: 1,
                              limit: _itemsPerPage,
                            ),
                          ),
                        );
                  },
                  child: Text(
                    "Retry",
                  ),
                ),
              );
            }
          }),
        );
      } else {
        return Center(child: Text("Failed to fetch Restaurant Details."));
      }
    });
  }
}
