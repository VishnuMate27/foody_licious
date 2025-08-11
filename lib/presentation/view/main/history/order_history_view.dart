import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/presentation/view/product/restaurant_details_view.dart';
import 'package:foody_licious/presentation/widgets/caller_info_card.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:foody_licious/presentation/widgets/menu_item_card.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cart/cart_view.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text(
          "Order History",
          style: GoogleFonts.yeonSung(
            color: kTextRed,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: kWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 18.h),
            Container(
              height: 230.h,
              decoration: BoxDecoration(
                color: kCardBackground,
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(
                  color: kBorder,
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Call For Information",
                      style: GoogleFonts.yeonSung(
                        color: kTextRed,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    CallerInfoCard(
                        callerImageUrl: kProfilePhoto,
                        callerName: "Mr Kemplas",
                        hotelDistance: "20 minutes on the way",
                        contactNumber: 1234567890),
                    SizedBox(height: 8.h),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: kWhite),
                          width: 260.w,
                          height: 68.h,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.phone_fill,
                                color: kGreen,
                                size: 24,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Call",
                                style: GoogleFonts.yeonSung(
                                    color: kGreen, fontSize: 18),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18.h),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: MenuItemCard.historyItem(
                    itemImageUrl: kMenuPhoto1,
                    itemName: "Herbal Pancake",
                    hotelName: "Warung Herbal",
                    itemPrice: 7,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RestaurantDetailsView(),
                        ),
                      );
                    },
                    onBuyAgainTap: () {},
                  ),
                );
              },
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}
