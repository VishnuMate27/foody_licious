import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/presentation/view/post_auth/restaurant_details_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';

class MenuItemCard extends StatefulWidget {
  final String itemImageUrl;
  final String itemName;
  final String hotelName;
  final num itemPrice;
  final Function()? onTap;

  final bool showCheckBox;
  final bool isInitiallyChecked;
  final bool isRestaurantMenuItem;
  final Function()? onSeeDetailsPressed;

  final bool isCartItem;
  final num? itemQuantity;
  final Function()? onDeleteButtonPressed;

  final bool isHistoryItem;
  final Function()? onBuyAgainTap;

  const MenuItemCard({
    super.key,
    required this.itemImageUrl,
    required this.itemName,
    required this.hotelName,
    required this.itemPrice,
    this.showCheckBox = false,
    this.isInitiallyChecked = false,
    this.isCartItem = false,
    this.itemQuantity,
    this.onDeleteButtonPressed,
    this.isRestaurantMenuItem = false,
    this.isHistoryItem = false,
    this.onTap,
    this.onBuyAgainTap,
    this.onSeeDetailsPressed,
  });

  const MenuItemCard.checkBox({
    super.key,
    required this.itemImageUrl,
    required this.itemName,
    required this.hotelName,
    required this.itemPrice,
    this.isInitiallyChecked = false,
    required this.onTap,
  })  : showCheckBox = true,
        isCartItem = false,
        itemQuantity = null,
        onDeleteButtonPressed = null,
        isHistoryItem = false,
        onBuyAgainTap = null,
        onSeeDetailsPressed = null,
        isRestaurantMenuItem = false;

  const MenuItemCard.retraurantMenuItem({
    super.key,
    required this.itemImageUrl,
    required this.itemName,
    required this.hotelName,
    required this.itemPrice,
    this.isInitiallyChecked = false,
    required this.onTap,
    required this.onSeeDetailsPressed,
  })  : showCheckBox = true,
        isCartItem = false,
        itemQuantity = null,
        onDeleteButtonPressed = null,
        isHistoryItem = false,
        onBuyAgainTap = null,
        isRestaurantMenuItem = true;

  const MenuItemCard.cartItem({
    super.key,
    required this.itemImageUrl,
    required this.itemName,
    required this.hotelName,
    required this.itemPrice,
    required this.itemQuantity,
    required this.onTap,
    required this.onDeleteButtonPressed,
  })  : isCartItem = true,
        showCheckBox = false,
        isInitiallyChecked = false,
        isHistoryItem = false,
        onBuyAgainTap = null,
        onSeeDetailsPressed = null,
        isRestaurantMenuItem = false;

  const MenuItemCard.historyItem({
    super.key,
    required this.itemImageUrl,
    required this.itemName,
    required this.hotelName,
    required this.itemPrice,
    required this.onTap,
    required this.onBuyAgainTap,
  })  : isHistoryItem = true,
        isCartItem = false,
        showCheckBox = false,
        isInitiallyChecked = false,
        itemQuantity = null,
        onDeleteButtonPressed = null,
        onSeeDetailsPressed = null,
        isRestaurantMenuItem = false;

  @override
  State<MenuItemCard> createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  late bool isChecked;
  late num quantity;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isInitiallyChecked;
    quantity = widget.itemQuantity ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCartItem) {
      return _buildCartItem(context);
    } else if (widget.isHistoryItem) {
      return _buildHistoryItem(context);
    } else if (widget.isRestaurantMenuItem) {
      return _buildRestaurantMenuItem(context);
    } else {
      return _buildMenuItem(context);
    }
  }

  Widget _buildMenuItem(BuildContext context) {
    Color getColor(Set<WidgetState> states) {
      const interactiveStates = <WidgetState>{WidgetState.selected};
      if (states.any(interactiveStates.contains)) {
        return kTextRed;
      }
      return kWhite;
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 87.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: kBorder),
        ),
        child: Row(
          children: [
            SizedBox(width: 10.w),
            Image.asset(widget.itemImageUrl, width: 64.h, height: 64.h),
            SizedBox(width: 20.w),
            Column(
              children: [
                SizedBox(height: 20.h),
                Text(
                  widget.itemName,
                  style: GoogleFonts.yeonSung(
                    color: kBlack,
                    fontSize: 15,
                  ),
                ),
                Text(
                  widget.hotelName,
                  style: GoogleFonts.lato(
                    color: kTextSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(width: 70.w),
            widget.showCheckBox
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "\$${widget.itemPrice}",
                        style: const TextStyle(
                          fontFamily: 'BentonSans',
                          color: kTextRed,
                          fontSize: 24,
                        ),
                      ),
                      Checkbox(
                        checkColor: kWhite,
                        fillColor: WidgetStateProperty.resolveWith(getColor),
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                    ],
                  )
                : Text(
                    "\$${widget.itemPrice}",
                    style: const TextStyle(
                      fontFamily: 'BentonSans',
                      color: kTextRed,
                      fontSize: 28,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantMenuItem(BuildContext context) {
    Color getColor(Set<WidgetState> states) {
      const interactiveStates = <WidgetState>{WidgetState.selected};
      if (states.any(interactiveStates.contains)) {
        return kTextRed;
      }
      return kWhite;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\u2022 ${widget.itemName}",
          style: GoogleFonts.lato(color: kBlack, fontSize: 16),
        ),
        Row(
          children: [
            TextButton(
              onPressed: widget.onSeeDetailsPressed,
              child: Text(
                "See Details",
                style: GoogleFonts.lato(color: kTextRed, fontSize: 14),
              ),
            ),
            Checkbox(
              checkColor: kWhite,
              fillColor: WidgetStateProperty.resolveWith(getColor),
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value ?? false;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCartItem(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 87.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: kBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10.w),
            Image.asset(widget.itemImageUrl, width: 64.h, height: 64.h),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.itemName,
                    style: GoogleFonts.yeonSung(
                      color: kBlack,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.hotelName,
                    style: GoogleFonts.lato(
                      color: kTextSecondary,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "\$ ${widget.itemPrice}",
                    style: GoogleFonts.lato(
                      color: kTextRed,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kGreen.withAlpha(51),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        width: 26.w,
                        height: 26.h,
                        child: Icon(
                          CupertinoIcons.minus,
                          color: kTextRed,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "$quantity",
                      style: GoogleFonts.lato(
                        color: kTextSecondary,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          gradient: LinearGradient(
                            colors: [kGradientStart, kGradientEnd],
                            stops: [0.0, 1.0],
                          ),
                        ),
                        width: 26.w,
                        height: 26.h,
                        child: Icon(
                          CupertinoIcons.plus,
                          color: kWhite,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: widget.onDeleteButtonPressed,
                  icon: Icon(CupertinoIcons.delete, color: kBlack, size: 20),
                ),
              ],
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 87.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: kBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10.w),
            Image.asset(widget.itemImageUrl, width: 64.h, height: 64.h),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.itemName,
                    style: GoogleFonts.yeonSung(
                      color: kBlack,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.hotelName,
                    style: GoogleFonts.lato(
                      color: kTextSecondary,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "\$ ${widget.itemPrice}",
                    style: GoogleFonts.lato(
                      color: kTextRed,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            GradientButton(
              buttonText: "Buy Again",
              onTap: widget.onBuyAgainTap,
              width: 84,
              height: 28,
              borderRadius: 5,
              fontSize: 12,
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}
