import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 82.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Explore Your Favorite Food",
                  style: GoogleFonts.yeonSung(
                      color: Color(0xFFE85353), fontSize: 24),
                ),
                Icon(
                  CupertinoIcons.bell,
                  size: 24,
                  color: Color(0xFF6CCB94),
                )
              ],
            ),
            SizedBox(
              height: 18.h,
            ),
            SearchBar(
              // controller: controller,
              hintText: "What do you want to order?",
              hintStyle: MaterialStatePropertyAll<TextStyle>(
                GoogleFonts.lato(
                    color: Color(0xFF9F4040),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.5),
              ),
              shadowColor: MaterialStatePropertyAll<Color>(Color(0xFFFFFFF)),
              backgroundColor:
                  MaterialStatePropertyAll<Color>(Color(0xFFFAEFEF)),
              shape: MaterialStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
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
              leading: const Icon(
                CupertinoIcons.search,
                color: Color(0xFF9F4040),
                size: 28,
                weight: 800,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/banner3.png",
                    height: 172.h,
                    width: 282.w,
                  ),
                  Image.asset(
                    "assets/images/banner1.png",
                    height: 172.h,
                    width: 282.w,
                  ),
                  Image.asset(
                    "assets/images/banner2.png",
                    height: 172.h,
                    width: 282.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 26.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular",
                    style: GoogleFonts.yeonSung(
                        color: Color(0xFFE85353),
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.5),
                  ),
                  Text(
                    "View More",
                    style: GoogleFonts.lato(
                        color: Color(0xFFE85353),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.5),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              height: 87.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Color(0x51FF8080),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Image.asset("assets/images/MenuPhoto1.png",
                      width: 64.h, height: 64.h),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Herbal Pancake",
                        style: GoogleFonts.yeonSung(
                            color: Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Warung Herbal",
                        style: GoogleFonts.lato(
                            color: Color(0xFF3B3B3B),
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80.w,
                  ),
                  Text(
                    "\$${7}",
                    style: TextStyle(
                        fontFamily: 'BentonSans',
                        color: Color(0xFFE85353),
                        fontSize: 28),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 87.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Color(0x51FF8080),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Image.asset("assets/images/MenuPhoto1.png",
                      width: 64.h, height: 64.h),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Herbal Pancake",
                        style: GoogleFonts.yeonSung(
                            color: Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Warung Herbal",
                        style: GoogleFonts.lato(
                            color: Color(0xFF3B3B3B),
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80.w,
                  ),
                  Text(
                    "\$${7}",
                    style: TextStyle(
                        fontFamily: 'BentonSans',
                        color: Color(0xFFE85353),
                        fontSize: 28),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 87.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Color(0x51FF8080),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Image.asset("assets/images/MenuPhoto1.png",
                      width: 64.h, height: 64.h),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Herbal Pancake",
                        style: GoogleFonts.yeonSung(
                            color: Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Warung Herbal",
                        style: GoogleFonts.lato(
                            color: Color(0xFF3B3B3B),
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80.w,
                  ),
                  Text(
                    "\$${7}",
                    style: TextStyle(
                        fontFamily: 'BentonSans',
                        color: Color(0xFFE85353),
                        fontSize: 28),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
