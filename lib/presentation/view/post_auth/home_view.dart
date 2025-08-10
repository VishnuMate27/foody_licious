import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/presentation/widgets/menu_item_card.dart';
import 'package:foody_licious/presentation/widgets/search_bar_field.dart';
import 'package:foody_licious/utils/custom_widgets.dart';
import 'package:foody_licious/presentation/view/post_auth/restaurant_details_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notification_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Explore Your Favorite Food",
                    style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 24),
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
              SizedBox(
                height: 18.h,
              ),
              SearchBarField(
                searchController: _searchController,
              ),
              SizedBox(
                height: 10.h,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 172.h,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                ),
                items: [
                  kBanner1,
                  kBanner2,
                  kBanner3,
                ].map((img) {
                  return Container(
                    height: 172.h,
                    width: 282.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                        image: AssetImage(
                          img,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular",
                      style: GoogleFonts.yeonSung(
                          color: kTextRed,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.5),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "View More",
                        style: GoogleFonts.lato(
                            color: kTextRed,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.5),
                      ),
                    ),
                  ],
                ),
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
                      child: MenuItemCard(
                        itemImageUrl: kMenuPhoto1,
                        itemName: "Herbal Pancake",
                        hotelName: "Warung Herbal",
                        itemPrice: 7,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RestaurantDetailsView(),
                            ),
                          );
                        },
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
