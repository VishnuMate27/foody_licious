import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class SetLocationView extends StatefulWidget {
  const SetLocationView({super.key});

  @override
  State<SetLocationView> createState() => _SetLocationViewState();
}

class _SetLocationViewState extends State<SetLocationView> {
  String dropdownValue = availableCitiesList.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 102.h,
              ),
              Text(
                "Choose Your Location",
                style: GoogleFonts.yeonSung(color: kTextRedDark, fontSize: 25),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 20.h,
              ),
              DropdownMenu<String>(
                trailingIcon: Icon(
                  Icons.arrow_circle_down,
                  size: 30,
                  color: kBlack,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorderLight, // Make the border transparent
                      width: 1, // Set the border width to 0
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Transparent border when not focused
                      width: 1.sp,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Transparent border when focused
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kError, // Transparent border for error state
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Transparent border when disabled
                      width: 1,
                    ),
                  ),
                ),
                initialSelection: availableCitiesList.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries: availableCitiesList
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
                expandedInsets: EdgeInsets.zero,
              ),
              SizedBox(
                height: 186.h,
              ),
              Text(
                "To provide you with the best dining experience, we need your permission to access your device's location. By enabling location services, we can offer personalized restaurant recommendations, accurate delivery estimates, and ensure a seamless food delivery experience.",
                style: GoogleFonts.lato(color: kBlack, fontSize: 16),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
