import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:foody_licious/presentation/widgets/menu_item_card.dart';
import 'package:foody_licious/presentation/widgets/custom_check_box.dart';
import 'package:foody_licious/core/utils/data.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItemDetailsView extends StatefulWidget {
  const MenuItemDetailsView({super.key});

  @override
  State<MenuItemDetailsView> createState() => _MenuItemDetailsViewState();
}

class _MenuItemDetailsViewState extends State<MenuItemDetailsView> {
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
                  "Food Name",
                  style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 28),
                ),
              ),
              SizedBox(
                height: 26.h,
              ),
              Center(
                child: Image.asset(
                  kMenuItemPhoto,
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
                "Ingredients",
                style: GoogleFonts.yeonSung(color: kBlack, fontSize: 20),
              ),
              SizedBox(
                child: ListView.builder(
                    physics:
                        ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        "\u2022 ${"Strawberry"}",
                        style: GoogleFonts.lato(color: kBlack, fontSize: 16),
                      );
                    }),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: GradientButton(
                  buttonText: "Add to Cart",
                  onTap: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
