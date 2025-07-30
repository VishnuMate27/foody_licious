import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: GoogleFonts.yeonSung(
            color: Color(0xFFE85353),
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const ImageIcon(
            AssetImage("assets/icons/back_arrow.png"),
            color: Color(0xFFFEAD1D), // Set the color of the back arrow
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            // Text(
            //   "No Notifications",
            //   style: TextStyle(
            //     color: Color(0xCCFF0000),
            //     fontSize: 24,
            //     fontWeight: FontWeight.normal,
            //     letterSpacing: 0.5,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // Icon(
            //   CupertinoIcons.bell_slash_fill,
            //   size: 50,
            //   color: Colors.grey,
            // ),
            SizedBox(
              height: 20.h,
            ),
            ListView.builder(
              physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
              shrinkWrap: true,
              itemCount: 3,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: NotificationEntry(
                    title: "Your order has been placed successfully.",
                    subject: "",
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationEntry extends StatelessWidget {
  final String title;
  final String subject;
  const NotificationEntry(
      {super.key, required this.title, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icons/delivery_truck.png",
          width: 25.w,
          height: 25.h,
        ),
        Text(
          "title",
          style: GoogleFonts.lato(color: const Color(0xFFE85353), fontSize: 15),
        ),
      ],
    );
  }
}
