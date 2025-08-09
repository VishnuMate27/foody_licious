import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarField extends StatelessWidget {
  final TextEditingController searchController;
  const SearchBarField({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: searchController,
      hintText: "What do you want to order?",
      hintStyle: MaterialStatePropertyAll<TextStyle>(
        GoogleFonts.lato(
            color: kRed,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.5),
      ),
      shadowColor: MaterialStatePropertyAll<Color>(kBlack),
      backgroundColor: MaterialStatePropertyAll<Color>(kBackground),
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
      leading: Icon(
        CupertinoIcons.search,
        color: kRed,
        size: 28,
        weight: 800,
      ),
    );
  }
}
