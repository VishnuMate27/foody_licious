import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/presentation/view/post_auth/menu_item_details_view.dart';
import 'package:foody_licious/presentation/widgets/menu_item_card.dart';
import 'package:foody_licious/utils/custom_widgets.dart';
import 'package:foody_licious/utils/data.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantDetailsView extends StatefulWidget {
  const RestaurantDetailsView({super.key});

  @override
  State<RestaurantDetailsView> createState() => _RestaurantDetailsViewState();
}

class _RestaurantDetailsViewState extends State<RestaurantDetailsView> {
  List<bool> isItemCheckedList = List<bool>.generate(15, (index) => false);
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Restaurant Name",
                  style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 28),
                ),
              ),
              SizedBox(
                height: 26.h,
              ),
              Center(
                child: Image.asset(
                  kRestraurant,
                  height: 200.h,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Short description",
                style: GoogleFonts.yeonSung(color: kBlack, fontSize: 20),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad",
                style: GoogleFonts.lato(
                    color: kBlack, fontSize: 14, letterSpacing: 0.5),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Menu",
                style: GoogleFonts.yeonSung(color: kBlack, fontSize: 20),
              ),
              SizedBox(
                height: 6.h,
              ),
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                    physics:
                        ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return MenuItemCard.retraurantMenuItem(
                        itemImageUrl: kMenuPhoto1,
                        itemName: "Herbal Pancake",
                        hotelName: "Warung Herbal",
                        itemPrice: 7,
                        isInitiallyChecked: false,
                        onTap: () {},
                        onSeeDetailsPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MenuItemDetailsView(),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
