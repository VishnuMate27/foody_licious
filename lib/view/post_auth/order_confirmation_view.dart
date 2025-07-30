import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cubit/navigation_cubit.dart';
import '../bottom_nav_bar.dart';
import 'home_view.dart';

class OrderConfirmationView extends StatefulWidget {
  const OrderConfirmationView({super.key});

  @override
  State<OrderConfirmationView> createState() => _OrderConfirmationViewState();
}

class _OrderConfirmationViewState extends State<OrderConfirmationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 120.h),
        child: Center(
          child: Column(
            children: [
              Text(
                "Congrats\nYour Order Placed",
                style: GoogleFonts.yeonSung(
                  color: Color(0xCCFF0000),
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48.h),
              Image.asset("assets/icons/order_placed_tick.png"),
              SizedBox(height: 58.h),
              GestureDetector(
                onTap: (){
                  context.read<NavigationCubit>().changeTab(0);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: [Color(0xFFE85353),Color(0xFFBE1515)],stops: [0.0,1.0],)
                  ),
                  width: 157.w,
                  height: 57.h,
                  child: Center(child: Text("Go Home",style: GoogleFonts.yeonSung(color: Color(0xFFFFFFFF),fontSize: 20),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
