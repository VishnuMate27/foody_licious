import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/extension/failure_extension.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/core/utils/data.dart';
import 'package:foody_licious/data/models/user/user_model.dart';
import 'package:foody_licious/domain/entities/user/user.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';
import 'package:foody_licious/presentation/bloc/auth/auth_bloc.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
import 'package:foody_licious/presentation/bloc/user/user_event.dart';
import 'package:foody_licious/presentation/bloc/user/user_state.dart';
import 'package:foody_licious/presentation/view/authentication/login_view.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:foody_licious/presentation/widgets/input_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String dropdownValue = availableCitiesList.first;
  User? _originalUser;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<UserBloc>().add(CheckUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserAuthenticated) {
          _originalUser = state.user;
          _nameController.text = state.user.name;
          _addressController.text = state.user.address?.addressText ?? "";
          _emailController.text = state.user.email ?? "";
          _phoneController.text = state.user.phone ?? "";

          if (state.user.address?.city != null) {
            setState(() {
              dropdownValue = state.user.address!.city!;
            });
          }
        } else if (state is UserUnauthenticated) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to get user info!",
            ),
          );
        } else if (state is UserUpdateSuccess) {
          _originalUser = state.user;
          _nameController.text = state.user.name;
          _addressController.text = state.user.address?.addressText ?? "";
          _emailController.text = state.user.email ?? "";
          _phoneController.text = state.user.phone ?? "";

          if (state.user.address?.city != null) {
            setState(() {
              dropdownValue = state.user.address!.city!;
            });
          }
          EasyLoading.showSuccess("User Info Updated Successfully!");
        } else if (state is UserUpdateFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to update user Info!",
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          title: Text(
            "Profile",
            style: GoogleFonts.yeonSung(
              color: kTextRed,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          backgroundColor: kWhite,
          actions: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  EasyLoading.show(status: "Logging Out...");
                } else if (state is AuthLoggedOut) {
                  EasyLoading.dismiss();
                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil(
                    AppRouter.login,
                    (Route<dynamic> route) => false,
                  );
                } else if (state is AuthLoggedOutFailed) {
                  EasyLoading.showError(
                    state.failure.toMessage(
                      defaultMessage: "Failed to Logout!",
                    ),
                  );
                }
              },
              child: IconButton(
                icon: const Icon(Icons.logout, color: kTextRed),
                tooltip: "Logout",
                onPressed: () {
                  // Dispatch logout event to AuthBloc
                  context.read<AuthBloc>().add(AuthSignOut());
                },
              ),
            ),
          ],
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
                        color: kTextRed, fontSize: 24, letterSpacing: 1.0),
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
                    suffixIcon: Icon(CupertinoIcons.create, color: kBlack),
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
                    suffixIcon: Icon(CupertinoIcons.create, color: kBlack),
                    hintText: "Enter full address",
                    keyboardType: TextInputType.streetAddress,
                    validatorText: "Please enter your full address",
                    minLines: 2,
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: 12.h,
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
                    initialSelection: dropdownValue,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    dropdownMenuEntries: availableCitiesList
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                    expandedInsets: EdgeInsets.zero,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  InputTextFormField(
                    readOnly: (_originalUser?.authProvider == "google" ||
                        _originalUser?.authProvider == "email"),
                    textController: _emailController,
                    labelText: "Email",
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
                    suffixIcon: (_originalUser?.authProvider == "google" ||
                            _originalUser?.authProvider == "email")
                        ? Tooltip(
                            message: _originalUser?.authProvider == "google"
                                ? "Email linked with Google account can’t be changed"
                                : "Email linked with your account can’t be changed",
                            child: Icon(
                              CupertinoIcons.lock,
                              color: kBlack,
                            ),
                          )
                        : Icon(
                            CupertinoIcons.create,
                            color: kBlack,
                          ),
                    hintText: "Enter your email address",
                    keyboardType: TextInputType.emailAddress,
                    validatorText: "Please enter your valid email",
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  InputTextFormField(
                    readOnly: (_originalUser?.authProvider == "phone"),
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
                    suffixIcon: (_originalUser?.authProvider == "phone")
                        ? Tooltip(
                            message:
                                "Phone number linked with your account can’t be changed",
                            child: Icon(
                              CupertinoIcons.lock,
                              color: kBlack,
                            ),
                          )
                        : Icon(
                            CupertinoIcons.create,
                            color: kBlack,
                          ),
                    hintText: "Enter your 10 digit phone number",
                    keyboardType: TextInputType.phone,
                    validatorText: "Please enter your valid phone number",
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      String? authProviderLogo;
                      IconData? authProviderIconData;
                      if (state is UserAuthenticated ||
                          state is UserUpdateSuccess) {
                        final user = state is UserAuthenticated
                            ? state.user
                            : (state as UserUpdateSuccess).user;
                        if (user.authProvider != null) {
                          if (user.authProvider == "google") {
                            authProviderLogo = kGoogleIcon;
                          } else if (user.authProvider == "facebook") {
                            authProviderLogo = kFacebookIcon;
                          } else if (user.authProvider == "phone") {
                            authProviderIconData = Icons.phone_outlined;
                          } else if (user.authProvider == "email") {
                            authProviderIconData = Icons.mail_outlined;
                          }
                        }
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          decoration: ShapeDecoration(
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: kBorder, // same as enabledBorder
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Authentication Provider", // placeholder text
                                style: GoogleFonts.yeonSung(
                                  color: kBlack,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              authProviderLogo != null
                                  ? Image.asset(
                                      authProviderLogo,
                                      width: 25.w,
                                      height: 25.h,
                                    )
                                  : Icon(
                                      authProviderIconData,
                                      color: kBlack,
                                    ),
                            ],
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      _onSaveInfo(context);
                      debugPrint("Save Information tapped");
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
                          "Save Information",
                          style: GoogleFonts.yeonSung(
                              color: kTextRedDark, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GradientButton(
                    height: 50.h,
                    onTap: () {
                      context.read<UserBloc>().add(DeleteUser());
                    },
                    buttonText: "Delete Account",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSaveInfo(BuildContext context) {
    if (_originalUser == null) return;

    String? name;
    String? email;
    String? phone;
    AddressModel? address;

    // Compare and assign only changed fields
    if (_nameController.text.trim() != _originalUser!.name) {
      name = _nameController.text.trim();
    }

    if (_emailController.text.trim() != _originalUser!.email) {
      email = _emailController.text.trim();
    }

    if (_phoneController.text.trim() != _originalUser!.phone) {
      phone = _phoneController.text.trim();
    }

    if (_addressController.text.trim() !=
            (_originalUser!.address?.addressText ?? "") ||
        dropdownValue != (_originalUser!.address?.city ?? "")) {
      address = AddressModel(
        addressText: _addressController.text.trim(),
        city: dropdownValue,
      );
    }

    final params = UpdateUserParams(
      name: name,
      email: email,
      phone: phone,
      address: address,
    );

    if (params.toJson().isNotEmpty) {
      context.read<UserBloc>().add(UpdateUser(params));
    } else {
      EasyLoading.showInfo("No changes to update");
    }
  }
}
