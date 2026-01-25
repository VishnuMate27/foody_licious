import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/extension/failure_extension.dart';
import 'package:foody_licious/domain/usecase/checkout/cancel_checkout_usecase.dart';
import 'package:foody_licious/domain/usecase/payment/complete_payment_usecase.dart';
import 'package:foody_licious/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:foody_licious/presentation/bloc/payment/payment_bloc.dart';
import 'package:foody_licious/presentation/view/order/order_confirmation_view.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentView extends StatefulWidget {
  final String orderId;
  final String paymentId;
  const PaymentView(
      {super.key, required this.orderId, required this.paymentId});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final String selectedPaymentMode = "COD";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state is CancelCheckoutFailed) {
              EasyLoading.showError(
                state.failure
                    .toMessage(defaultMessage: "Failed to cancel checkout!"),
              );
            } else if (state is CancelCheckoutLoading) {
              EasyLoading.show(status: "Canceling Checkout...");
            } else if (state is CancelCheckoutSuccess) {
              EasyLoading.dismiss();
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is CompletePaymentFailed) {
              EasyLoading.showError(
                state.failure
                    .toMessage(defaultMessage: "Failed to complete payment!"),
              );
            } else if (state is CompletePaymentLoading) {
              EasyLoading.show(status: "Processing Payment...");
            } else if (state is CompletePaymentSuccess) {
              EasyLoading.dismiss();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderConfirmationView(),
                ),
              );
            }
          },
        )
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: kWhite,
          appBar: AppBar(
            backgroundColor: kWhite,
            elevation: 0,
            leading: IconButton(
              icon: ImageIcon(
                AssetImage(kBackArrowIcon),
                color: kYellow, // Set the color of the back arrow
              ),
              onPressed: () async {
                final shouldCancel = await _showCancelCheckoutDialog(context);
                if (shouldCancel) {
                  context.read<CheckoutBloc>().add(
                        CancelCheckout(
                          CancelCheckoutParams(
                            orderId: widget.orderId,
                          ),
                        ),
                      );
                }
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Payment",
                    style: GoogleFonts.yeonSung(
                        color: kTextRed, fontSize: 24, letterSpacing: 1.0),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(color: kBorder, width: 1.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.check_circle_outlined, color: kGreen),
                        Text(
                          "CASH ON DELIVERY",
                          style: GoogleFonts.yeonSung(
                            color: kTextSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Image.asset(
                          kCashOnDeliveryIcon,
                          width: 106,
                          height: 52,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 38.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<PaymentBloc>().add(
                            CompletePayment(
                              PaymentParams(
                                paymentId: widget.paymentId,
                                paymentMode: selectedPaymentMode,
                              ),
                            ),
                          );
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
                          "Place Order",
                          style: GoogleFonts.yeonSung(
                            color: kTextRedDark,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showCancelCheckoutDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Cancel Checkout"),
        content: const Text(
          "Are you sure you want to cancel checkout?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text("Yes"),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}
