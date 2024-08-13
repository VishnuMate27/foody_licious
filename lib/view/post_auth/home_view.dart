import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/utils/custom_widgets.dart';
import 'package:foody_licious/view/post_auth/food_details_view.dart';
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
              ListView.builder(
                  physics:
                      ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: 5,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child:  MenuItemCard(
                          itemImageUrl: "assets/images/MenuPhoto1.png",
                          itemName: "Herbal Pancake",
                          hotelName: "Warung Herbal",
                          itemPrice: 7),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItemCard extends StatefulWidget {
  final String itemImageUrl;
  final String itemName;
  final String hotelName;
  final num itemPrice;
  bool showCheckBox = false;
  bool? isChecked = false;

  MenuItemCard({
    super.key,
    required this.itemImageUrl,
    required this.itemName,
    required this.hotelName,
    required this.itemPrice,
  });

  // Named constructor with showCheckBox set to true
  MenuItemCard.checkBox({
    super.key,
    required this.itemImageUrl,
    required this.itemName,
    required this.hotelName,
    required this.itemPrice,
    this.isChecked = false,
  }) : showCheckBox = true;


  @override
  State<MenuItemCard> createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.selected,
      };
      if (states.any(interactiveStates.contains)) {
        return Color(0xFFE85353);
      }
      return Colors.white;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FoodDetailsView()),
        );
      },
      child: Container(
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
            Image.asset(widget.itemImageUrl, width: 64.h, height: 64.h),
            SizedBox(
              width: 20.w,
            ),
            Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  widget.itemName,
                  style: GoogleFonts.yeonSung(
                    color: Color(0xFF000000),
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  widget.hotelName,
                  style: GoogleFonts.lato(
                    color: Color(0xFF3B3B3B),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 80.w,
            ),
            widget.showCheckBox
                ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "\$${widget.itemPrice}",
                  style: TextStyle(
                    fontFamily: 'BentonSans',
                    color: Color(0xFFE85353),
                    fontSize: 24,
                  ),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: widget.isChecked ?? false, // Ensure value is not null
                  onChanged: (bool? value) {
                    setState(() {
                      widget.isChecked = value;
                    });
                  },
                ),
              ],
            )
                : Text(
              "\$${widget.itemPrice}",
              style: TextStyle(
                fontFamily: 'BentonSans',
                color: Color(0xFFE85353),
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

