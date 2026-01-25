import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/extension/failure_extension.dart';
import 'package:foody_licious/domain/usecase/checkout/place_order_usecase.dart';
import 'package:foody_licious/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
import 'package:foody_licious/presentation/bloc/user/user_event.dart';
import 'package:foody_licious/presentation/bloc/user/user_state.dart';
import 'package:foody_licious/presentation/view/order/payment_view.dart';
import 'package:foody_licious/presentation/widgets/input_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class PayoutView extends StatefulWidget {
  const PayoutView({super.key});

  @override
  State<PayoutView> createState() => _PayoutViewState();
}

class _PayoutViewState extends State<PayoutView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    context.read<UserBloc>().add(CheckUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state is PlaceOrderFailed) {
              EasyLoading.showError(
                state.failure
                    .toMessage(defaultMessage: "Failed to place order!"),
              );
            } else if (state is PlaceOrderLoading) {
              EasyLoading.show(status: "Proccesing to payment...");
            } else if (state is PlaceOrderSuccess) {
              EasyLoading.dismiss();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentView(
                    orderId: state.placeOrderDetails.orderId,
                    paymentId: state.placeOrderDetails.paymentId,
                  ),
                ),
              );
            }
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserUnauthenticated) {
              EasyLoading.showError(
                state.failure
                    .toMessage(defaultMessage: "Failed to get user details!"),
              );
            } else if (state is UserAuthenticated) {
              _nameController = TextEditingController(text: state.user.name);
              _addressController = TextEditingController(
                  text:
                      "${state.user.address?.addressText}, ${state.user.address?.city}");
              _phoneController =
                  TextEditingController(text: state.user.phone);
            } else {
              EasyLoading.dismiss();
            }
          },
        )
      ],
      child: BlocBuilder<UserBloc, UserState>(
          buildWhen: (previous, current) =>
              (previous is UserLoading && current is UserAuthenticated),
          builder: (context, state) {
            return Scaffold(
              backgroundColor: kWhite,
              appBar: AppBar(
                backgroundColor: kWhite,
                elevation: 0,
                leading: IconButton(
                  icon: ImageIcon(
                    AssetImage(kBackArrowIcon),
                    color: kYellow, // Set the color of the back arrow
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Edit",
                          style: GoogleFonts.yeonSung(
                              color: kTextRed,
                              fontSize: 24,
                              letterSpacing: 1.0),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InputTextFormField(
                          textController: _nameController,
                          labelText: "Name",
                          labelStyle: GoogleFonts.yeonSung(
                            color: kBlack,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                          hintStyle: GoogleFonts.lato(
                            color: kBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.5,
                          ),
                          suffixIcon:
                              Icon(CupertinoIcons.create, color: kBlack),
                          hintText: "Enter name",
                          keyboardType: TextInputType.name,
                          validatorText: "Please enter your name",
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        InputTextFormField(
                          textController: _addressController,
                          labelText: "Address",
                          labelStyle: GoogleFonts.yeonSung(
                            color: kBlack,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                          hintStyle: GoogleFonts.lato(
                            color: kBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.5,
                          ),
                          suffixIcon:
                              Icon(CupertinoIcons.create, color: kBlack),
                          hintText: "Enter full address",
                          keyboardType: TextInputType.streetAddress,
                          validatorText: "Please enter your full address",
                          minLines: 2,
                          maxLines: 5,
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        InputTextFormField(
                          textController: _phoneController,
                          labelText: "Phone",
                          labelStyle: GoogleFonts.yeonSung(
                            color: kBlack,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                          hintStyle: GoogleFonts.lato(
                              color: kBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.5),
                          suffixIcon:
                              Icon(CupertinoIcons.create, color: kBlack),
                          hintText: "Enter your 10 digit phone number",
                          keyboardType: TextInputType.phone,
                          validatorText:
                              "Please enter your valid phone number",
                        ),
                        SizedBox(
                          height: 38.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<CheckoutBloc>().add(
                                    PlaceOrder(
                                      PlaceOrderParams(
                                        name: _nameController.text,
                                        address: _addressController.text,
                                        phone: _phoneController.text,
                                      ),
                                    ),
                                  );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: kTextOnPrimary,
                                border: Border.all(
                                  color: kBorder,
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    color: kBlack.withAlpha(26),
                                    blurRadius: 4,
                                  )
                                ]),
                            height: 57.h,
                            child: Center(
                              child: Text(
                                "Proceed to Payment",
                                style: GoogleFonts.yeonSung(
                                    color: kTextRedDark, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
