import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/router/tab_navigator.dart';
import 'package:foody_licious/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItemDetailsView extends StatefulWidget {
  final MenuItem menuItem;
  const MenuItemDetailsView({super.key, required this.menuItem});

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
                  widget.menuItem.name,
                  style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 28),
                ),
              ),
              SizedBox(
                height: 26.h,
              ),
              Center(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200.h,
                    autoPlay: true,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                  ),
                  items: widget.menuItem.images?.map((url) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        image: DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Restaurant Name",
                style: GoogleFonts.yeonSung(color: kBlack, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.menuItem.restaurantName ??
                        "Failed to fetch restaurant name.",
                    style: GoogleFonts.lato(
                        color: kBlack, fontSize: 14, letterSpacing: 0.5),
                  ),
                  TextButton(
                    onPressed: () {
                      // View Restaurant Details Screen
                      TabNavigator.pushRestaurantDetails(
                        context,
                        widget.menuItem.restaurantId,
                      );
                    },
                    child: Text(
                      "view",
                      style: GoogleFonts.lato(
                          color: kBlack, fontSize: 14, letterSpacing: 0.5),
                    ),
                  )
                ],
              ),
              Text(
                "Short description",
                style: GoogleFonts.yeonSung(color: kBlack, fontSize: 20),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                widget.menuItem.description ?? "Description not available.",
                style: GoogleFonts.lato(
                    color: kBlack, fontSize: 14, letterSpacing: 0.5),
              ),
              SizedBox(
                height: 10.h,
              ),
              if (widget.menuItem.ingredients != null &&
                  widget.menuItem.ingredients!.isNotEmpty) ...[
                Text(
                  "Ingredients",
                  style: GoogleFonts.yeonSung(color: kBlack, fontSize: 20),
                ),
                ...widget.menuItem.ingredients!.map(
                  (ingredient) => Text("• $ingredient",
                      style: GoogleFonts.lato(fontSize: 16)),
                ),
              ],
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
