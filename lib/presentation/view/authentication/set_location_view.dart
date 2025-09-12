import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/extension/failure_extension.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/core/utils/data.dart';
import 'package:foody_licious/data/models/user/user_model.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
import 'package:foody_licious/presentation/bloc/user/user_event.dart';
import 'package:foody_licious/presentation/bloc/user/user_state.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class SetLocationView extends StatefulWidget {
  final String? previousCity;
  const SetLocationView({this.previousCity,super.key});

  @override
  State<SetLocationView> createState() => _SetLocationViewState();
}

class _SetLocationViewState extends State<SetLocationView>
    with WidgetsBindingObserver {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<UserBloc>().add(UpdateUserLocation());
    dropdownValue = widget.previousCity ?? availableCitiesList.first;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<UserBloc>().add(UpdateUserLocation());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (BuildContext context, UserState state) async {
        EasyLoading.dismiss();
        if (state is UserLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if(state is UserLocationUpdating){
          EasyLoading.show(status: 'Fetching Location...');
        }else if (state is UserUpdateLocationFailed) {
          if (state.failure is LocationServicesDisabledFailure) {
            await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Enable Location Services"),
                content: const Text(
                    "Location services are disabled. Please enable them."),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await Geolocator.openLocationSettings();
                    },
                    child: const Text("Open Settings"),
                  ),
                ],
              ),
            );
          } else if (state.failure
              is LocationPermissionPermanentlyDeniedFailure) {
            await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Permission Required"),
                content: const Text(
                    "Location permission is permanently denied. Please enable it in app settings."),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await openAppSettings();
                    },
                    child: const Text("Open App Settings"),
                  ),
                ],
              ),
            );
          } else if (state.failure is LocationPermissionDeniedFailure) {
            EasyLoading.showError("Location Permission Denied!");
          } else {
            EasyLoading.showError(
              state.failure.toMessage(
                defaultMessage: "Failed to fetch Location!",
              ),
            );
          }
        } else if (state is UserUpdateSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.home,
            (Route<dynamic> route) => false,
          );
        } else if (state is UserUpdateFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to update city!",
            ),
          );
        }
      },
      child: Scaffold(
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
                  style:
                      GoogleFonts.yeonSung(color: kTextRedDark, fontSize: 25),
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
                  height: 186.h,
                ),
                Text(
                  "To provide you with the best dining experience, we need your permission to access your device's location. By enabling location services, we can offer personalized restaurant recommendations, accurate delivery estimates, and ensure a seamless food delivery experience.",
                  style: GoogleFonts.lato(color: kBlack, fontSize: 16),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 40.h,
                ),
                Center(
                  child: GradientButton(
                    buttonText: "Continue",
                    onTap: () {
                      context.read<UserBloc>().add(UpdateUser(UpdateUserParams(
                          address: AddressModel(city: dropdownValue))));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
