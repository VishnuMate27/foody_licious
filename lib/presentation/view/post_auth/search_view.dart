import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/presentation/view/post_auth/home_view.dart';
import 'package:foody_licious/presentation/widgets/menu_item_card.dart';
import 'package:foody_licious/presentation/widgets/search_bar_field.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
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
              SizedBox(
                height: 18.h,
              ),
              SearchBarField(
                searchController: _searchController,
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Popular",
                style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 24),
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
                        isInitiallyChecked: false,
                        onTap: () {},
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
