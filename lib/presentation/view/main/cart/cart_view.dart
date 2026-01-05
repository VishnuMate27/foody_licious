import 'package:dartz/dartz.dart' as menuItem;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/domain/usecase/cart/decrease_item_quantity_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/delete_item_in_cart_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/get_all_cart_item_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/increase_item_quantity_usecase.dart';
import 'package:foody_licious/presentation/bloc/cart/cart_bloc.dart';
import 'package:foody_licious/presentation/cubit/pagination/pagination_cubit.dart';
import 'package:foody_licious/presentation/view/product/menu_item_details_view.dart';
import 'package:foody_licious/presentation/view/product/restaurant_details_view.dart';
import 'package:foody_licious/presentation/view/order/payout_view.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:foody_licious/presentation/widgets/menu_item_card.dart';
import 'package:foody_licious/presentation/widgets/search_bar_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../notification/notification_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final int _pageSize = 10;
  late final PaginationCubit _paginationCubit;

  @override
  void initState() {
    super.initState();
    _paginationCubit = PaginationCubit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // initial load
      context.read<CartBloc>().add(
            GetAllCartItem(GetAllCartItemParams(page: 1, limit: _pageSize)),
          );
    });

    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      final max = _scrollController.position.maxScrollExtent;
      final current = _scrollController.position.pixels;
      // when within 200px of bottom, try load more
      if (current >= (max - 200)) {
        final pstate = _paginationCubit.state;
        if (!pstate.isLoadingMore && pstate.hasMoreItems) {
          _paginationCubit.loadMoreItems();
          // trigger fetching next page
          context.read<CartBloc>().add(
                GetAllCartItem(
                  GetAllCartItemParams(
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
  void dispose() {
    _scrollController.dispose();
    _paginationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _paginationCubit,
      child: Scaffold(
        backgroundColor: kWhite,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Explore Your Favorite Food",
                      style: GoogleFonts.yeonSung(
                        color: kTextRed,
                        fontSize: 24,
                      ),
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
                SearchBarField(
                  searchController: _searchController,
                ),
                SizedBox(height: 12.h),
                Text(
                  "Cart",
                  style: GoogleFonts.yeonSung(
                    color: kTextRed,
                    fontSize: 24,
                  ),
                ),
                Expanded(
                  child: BlocConsumer<CartBloc, CartState>(
                      listenWhen: (previous, current) =>
                          current is IncreaseItemQuantityFailed ||
                          current is DecreaseItemQuantityFailed ||
                          current is DeleteItemInCartFailed ||
                          current is DeleteItemInCartSuccess ||
                          current is GetAllCartItemSuccess,
                      listener: (context, state) {
                        if (state is IncreaseItemQuantityFailed ||
                            state is DecreaseItemQuantityFailed) {
                          EasyLoading.showError(
                              "Failed to update item quantity");
                        } else if (state is DeleteItemInCartSuccess) {
                          EasyLoading.showSuccess(
                              "Cart Item Deleted Successfully!");
                        } else if (state is DeleteItemInCartFailed) {
                          EasyLoading.showError("Failed to delete cart item!");
                        } else if (state is GetAllCartItemSuccess) {
                          // determine whether there are more items based on page size
                          // if totalItems >= currentPage * pageSize => probably has more
                          final currentPage =
                              _paginationCubit.state.currentPage;
                          final totalItems = state.cartItems.length;
                          final hasMore =
                              totalItems >= (currentPage * _pageSize);
                          _paginationCubit.setHasMoreItems(hasMore);
                          // stop loadingMore flag (if any)
                          if (_paginationCubit.state.isLoadingMore) {
                            // ensure isLoadingMore reset; setHasMoreItems already resets isLoadingMore=false
                            // no-op here
                          }
                        }
                      },
                      buildWhen: (previous, current) {
                        // Allow rebuilds for these specific states
                        return current is GetAllCartItemSuccess ||
                            current is GetAllCartItemLoading ||
                            current is GetAllCartItemFailed;
                      },
                      builder: (context, state) {
                        if (state is GetAllCartItemLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is GetAllCartItemSuccess) {
                          return BlocBuilder<PaginationCubit, PaginationState>(
                            builder: (context, pState) {
                              final showLoader = pState.isLoadingMore;
                              final itemCount =
                                  state.cartItems.length + (showLoader ? 1 : 0);
                              return ListView.builder(
                                controller: _scrollController,
                                itemCount: itemCount,
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                itemBuilder: (BuildContext context, int index) {
                                  if (index >= state.cartItems.length) {
                                    // bottom loader
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  final cartItem = state.cartItems[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: MenuItemCard.cartItem(
                                      key: ValueKey(menuItem.id),
                                      itemImageUrl: (cartItem.menuItem?.images
                                                  ?.isNotEmpty ??
                                              false)
                                          ? cartItem.menuItem!.images!.first
                                          : "https://img.freepik.com/free-psd/hand-drawn-burger-illustration_23-2151600206.jpg",
                                      itemName: cartItem.menuItem?.name ??
                                          "Item Name",
                                      hotelName:
                                          cartItem.menuItem?.restaurantName ??
                                              "Warung Herbal",
                                      itemPrice: cartItem.totalPrice,
                                      itemQuantity: cartItem.quantity,
                                      onIncreaseItemButtonPressed: () {
                                        context.read<CartBloc>().add(
                                              IncreaseItemQuantity(
                                                IncreaseItemQuantityParams(
                                                  menuItemId:
                                                      cartItem.menuItemId,
                                                ),
                                              ),
                                            );
                                      },
                                      onDecreaseItemButtonPressed: () {
                                        context.read<CartBloc>().add(
                                              DecreaseItemQuantity(
                                                DecreaseItemQuantityParams(
                                                  menuItemId:
                                                      cartItem.menuItemId,
                                                ),
                                              ),
                                            );
                                      },
                                      onDeleteButtonPressed: () {
                                        context.read<CartBloc>().add(
                                              DeleteItemInCart(
                                                DeleteItemInCartParams(
                                                    menuItemId:
                                                        cartItem.menuItemId),
                                              ),
                                            );
                                      },
                                      onTap: () {
                                        if (cartItem.menuItem != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MenuItemDetailsView(
                                                menuItem: cartItem.menuItem!,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        } else if (state is GetAllCartItemFailed) {
                          return const Center(
                              child: Text("Failed to load items"));
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                ),
                SizedBox(height: 12.h),
                GradientButton(
                  buttonText: "Continue",
                  onTap: () {
                    showBottomSheet(context, () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PayoutView(),
                        ),
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showBottomSheet(BuildContext context, Function()? onProceedTap) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 240.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.r),
            image: DecorationImage(
                image: AssetImage(kBottomSheetBackground), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub-Total",
                      style:
                          GoogleFonts.lato(color: kTextOnPrimary, fontSize: 14),
                    ),
                    Text(
                      "120\$",
                      style:
                          GoogleFonts.lato(color: kTextOnPrimary, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Charge",
                      style:
                          GoogleFonts.lato(color: kTextOnPrimary, fontSize: 14),
                    ),
                    Text(
                      "10\$",
                      style:
                          GoogleFonts.lato(color: kTextOnPrimary, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount",
                      style:
                          GoogleFonts.lato(color: kTextOnPrimary, fontSize: 14),
                    ),
                    Text(
                      "20\$",
                      style:
                          GoogleFonts.lato(color: kTextOnPrimary, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: GoogleFonts.yeonSung(
                          color: kTextOnPrimary, fontSize: 18),
                    ),
                    Text(
                      "150\$",
                      style: GoogleFonts.yeonSung(
                          color: kTextOnPrimary, fontSize: 18),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onProceedTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kTextOnPrimary,
                    ),
                    height: 57.h,
                    child: Center(
                      child: Text(
                        "Proceed",
                        style:
                            GoogleFonts.yeonSung(color: kTextRed, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
