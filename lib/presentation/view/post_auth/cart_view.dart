import 'package:flutter/material.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/presentation/view/post_auth/payout_view.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:foody_licious/presentation/widgets/menu_item_card.dart';
import 'package:foody_licious/presentation/widgets/search_bar_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'notification_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
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
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: MenuItemCard.cartItem(
                        itemImageUrl: kMenuPhoto1,
                        itemName: "Herbal Pancake",
                        hotelName: "Warung Herbal",
                        itemPrice: 7,
                        itemQuantity: 1,
                        onDeleteButtonPressed: () {
                          debugPrint("Delete button tapped");
                        },
                      ),
                    );
                  },
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
