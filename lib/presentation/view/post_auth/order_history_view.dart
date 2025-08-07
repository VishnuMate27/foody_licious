import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cart_view.dart';

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
                  child: OrderHistoryItemCard(
                    itemImageUrl: kMenuPhoto1,
                    itemName: "Herbal Pancake",
                    restaurantName: "Warung Herbal",
                    itemPrice: 7,
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

class OrderHistoryItemCard extends StatefulWidget {
  final String itemImageUrl;
  final String itemName;
  final String restaurantName;
  final num itemPrice;

  OrderHistoryItemCard({
    super.key,
    required this.itemImageUrl,
    required this.itemName,
    required this.restaurantName,
    required this.itemPrice,
  });

  @override
  State<OrderHistoryItemCard> createState() => _OrderHistoryItemCardState();
}

class _OrderHistoryItemCardState extends State<OrderHistoryItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                    widget.restaurantName,
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
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    gradient: LinearGradient(
                      colors: [kGradientStart, kGradientEnd],
                      stops: [0.0, 1.0],
                    )),
                width: 84.w,
                height: 28.h,
                child: Center(
                    child: Text(
                  "Buy Again",
                  style: GoogleFonts.yeonSung(color: kWhite, fontSize: 12),
                )),
              ),
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}

class CallerInfoCard extends StatefulWidget {
  final String callerImageUrl;
  final String callerName;
  final String hotelDistance;
  final num contactNumber; // Example contact number

  CallerInfoCard({
    super.key,
    required this.callerImageUrl,
    required this.callerName,
    required this.hotelDistance,
    required this.contactNumber,
  });

  @override
  State<CallerInfoCard> createState() => _CallerInfoCardState();
}

class _CallerInfoCardState extends State<CallerInfoCard> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.selected,
      };
      if (states.any(interactiveStates.contains)) {
        return kTextRed;
      }
      return kWhite;
    }

    return Container(
      height: 87.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: kBorder,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          Image.asset(widget.callerImageUrl, width: 64.h, height: 64.h),
          SizedBox(
            width: 20.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                widget.callerName,
                style: GoogleFonts.yeonSung(
                  color: kBlack,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                widget.hotelDistance,
                style: GoogleFonts.lato(
                  color: kTextSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 60.w,
          ),
        ],
      ),
    );
  }
}
