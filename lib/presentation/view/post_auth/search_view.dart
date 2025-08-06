import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/presentation/view/post_auth/home_view.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFullWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 18.h,
              ),
              SearchBar(
                // controller: controller,
                hintText: "What do you want to order?",
                hintStyle: MaterialStatePropertyAll<TextStyle>(
                  GoogleFonts.lato(
                      color: kRed,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                ),
                shadowColor: MaterialStatePropertyAll<Color>(kFullBlack),
                backgroundColor: MaterialStatePropertyAll<Color>(kWhiteBgColor),
                shape: MaterialStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15.0), // Rounded corners
                  ),
                ),
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0)),
                onTap: () {
                  // controller.openView();
                },
                onChanged: (_) {
                  // controller.openView();
                },
                leading: Icon(
                  CupertinoIcons.search,
                  color: kRed,
                  size: 28,
                  weight: 800,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Popular",
                style: GoogleFonts.yeonSung(color: kRedFont, fontSize: 24),
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 12.h,
              ),
              ListView.builder(
                  physics:
                      ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: 5,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: MenuItemCard.checkBox(
                        itemImageUrl: kMenuPhoto1,
                        itemName: "Herbal Pancake",
                        hotelName: "Warung Herbal",
                        itemPrice: 7,
                        isChecked: false,
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
