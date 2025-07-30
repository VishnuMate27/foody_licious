import 'package:flutter/material.dart';
import 'package:foody_licious/view/post_auth/payout_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'notification_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Explore Your Favorite Food",
                      style: GoogleFonts.yeonSung(
                        color: Color(0xFFE85353),
                        fontSize: 24,
                      ),
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
                      icon: const Icon(
                        CupertinoIcons.bell,
                        size: 24,
                        color: Color(0xFF6CCB94),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                SearchBar(
                  hintText: "What do you want to order?",
                  hintStyle: MaterialStatePropertyAll<TextStyle>(
                    GoogleFonts.lato(
                      color: Color(0xFF9F4040),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5,
                    ),
                  ),
                  shadowColor: MaterialStatePropertyAll<Color>(Color(0xFFFFFFF)),
                  backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFFAEFEF)),
                  shape: MaterialStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  ),
                  onTap: () {},
                  onChanged: (_) {},
                  leading: const Icon(
                    CupertinoIcons.search,
                    color: Color(0xFF9F4040),
                    size: 28,
                    weight: 800,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Cart",
                  style: GoogleFonts.yeonSung(
                    color: Color(0xFFE85353),
                    fontSize: 24,
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: CartItemCard(
                        itemImageUrl: "assets/images/MenuPhoto1.png",
                        itemName: "Herbal Pancake",
                        restaurantName: "Warung Herbal",
                        itemPrice: 7,
                        itemQuantity: 1,
                      ),
                    );
                  },
                ),
                SizedBox(height: 12.h),
                GestureDetector(
                  onTap: (){
                    showBottomSheet(context, () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PayoutView(),
                        ),
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: [Color(0xFFE85353),Color(0xFFBE1515)],stops: [0.0,1.0],)
                    ),
                    height: 57.h,
                    child: Center(child: Text("Continue",style: GoogleFonts.yeonSung(color: Color(0xFFFFFFFF),fontSize: 20),)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  showBottomSheet(BuildContext context, Function()? onProceedTap) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 240.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.r),
            image: DecorationImage(image: AssetImage("assets/images/bottom_sheet_background.png"), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Sub-Total",style: GoogleFonts.lato(color: Color(0xFFFEFEFF),fontSize: 14),),
                    Text("120\$",style: GoogleFonts.lato(color: Color(0xFFFEFEFF),fontSize: 14),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Delivery Charge",style: GoogleFonts.lato(color: Color(0xFFFEFEFF),fontSize: 14),),
                    Text("10\$",style: GoogleFonts.lato(color: Color(0xFFFEFEFF),fontSize: 14),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discount",style: GoogleFonts.lato(color: Color(0xFFFEFEFF),fontSize: 14),),
                    Text("20\$",style: GoogleFonts.lato(color: Color(0xFFFEFEFF),fontSize: 14),),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total",style: GoogleFonts.yeonSung(color: Color(0xFFFEFEFF),fontSize: 18),),
                    Text("150\$",style: GoogleFonts.yeonSung(color: Color(0xFFFEFEFF),fontSize: 18),),
                  ],
                ),
                GestureDetector(
                  onTap: onProceedTap,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFFEFEFF),
                    ),
                    height: 57.h,
                    child: Center(child: Text("Proceed",style: GoogleFonts.yeonSung(color: Color(0xFFBE1515),fontSize: 20),)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class CartItemCard extends StatefulWidget {
  final String itemImageUrl;
  final String itemName;
  final String restaurantName;
  final num itemPrice;
  final num itemQuantity;

  CartItemCard({
    super.key,
    required this.itemImageUrl,
    required this.itemName,
    required this.restaurantName,
    required this.itemPrice,
    required this.itemQuantity,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 87.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Color(0x51FF8080)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10.w),
            Image.asset(widget.itemImageUrl, width: 64.h, height: 64.h),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.itemName,
                    style: GoogleFonts.yeonSung(
                      color: Color(0xFF000000),
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.restaurantName,
                    style: GoogleFonts.lato(
                      color: Color(0xFF3B3B3B),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "\$ ${widget.itemPrice}",
                    style: GoogleFonts.lato(
                      color: Color(0xFFE85353),
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("- button pressed");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBFBF2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        width: 26.w,
                        height: 26.h,
                        child: const Icon(
                          CupertinoIcons.minus,
                          color: Color(0xFFD53737),
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "${widget.itemQuantity}",
                      style: GoogleFonts.lato(
                        color: Color(0xFF181818),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () {
                        print("+ button pressed");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFD53737),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        width: 26.w,
                        height: 26.h,
                        child: const Icon(
                          CupertinoIcons.plus,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        print("Delete button pressed");
                      },
                      icon: Icon(CupertinoIcons.delete,
                          color: Colors.black, size: 20),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}
