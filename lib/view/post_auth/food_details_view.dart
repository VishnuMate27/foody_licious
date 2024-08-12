import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/utils/custom_widgets.dart';
import 'package:foody_licious/utils/data.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailsView extends StatefulWidget {
  const FoodDetailsView({super.key});

  @override
  State<FoodDetailsView> createState() => _FoodDetailsViewState();
}

class _FoodDetailsViewState extends State<FoodDetailsView> {
  List<bool> isItemCheckedList = List<bool>.generate(15, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset("assets/icons/back_arrow.png")),
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
                  style: GoogleFonts.yeonSung(
                      color: Color(0xFFE85353), fontSize: 28),
                ),
              ),
              SizedBox(
                height: 26.h,
              ),
              Center(
                child: Image.asset(
                  "assets/images/restraurant.png",
                  height: 200.h,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Short description",
                style: GoogleFonts.yeonSung(
                    color: Color(0xFF000000), fontSize: 20),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad",
                style: GoogleFonts.lato(
                    color: const Color(0xFF000000),
                    fontSize: 14,
                    letterSpacing: 0.5),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Menu",
                style: GoogleFonts.yeonSung(
                    color: Color(0xFF000000), fontSize: 20),
              ),
              SizedBox(
                height: 6.h,
              ),
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return MenuItem(
                        itemName: menuItemList[index],
                        isChecked: isItemCheckedList[index],
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

class MenuItem extends StatefulWidget {
  final String itemName;
  bool? isChecked = false;
  MenuItem({super.key, required this.itemName,required this.isChecked});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  // bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.selected
      };
      if (states.any(interactiveStates.contains)) {
        return Color(0xFFE85353);
      }
      return Colors.white;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\u2022 ${widget.itemName}",
          style: GoogleFonts.lato(color: Color(0xFF000000), fontSize: 16),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                "See Details",
                style: GoogleFonts.lato(color: Color(0xFFE85353), fontSize: 14),
              ),
            ),
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: widget.isChecked,
              onChanged: (bool? value) {
                setState(() {
                  widget.isChecked = value!;
                });
              },
            )
          ],
        ),
      ],
    );
  }
}

