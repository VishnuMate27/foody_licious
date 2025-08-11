import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/presentation/view/main/cart/cart_view.dart';
import 'package:foody_licious/presentation/view/main/home/home_view.dart';
import 'package:foody_licious/presentation/view/main/history/order_history_view.dart';
import 'package:foody_licious/presentation/view/main/profile/profile_view.dart';
import 'package:foody_licious/presentation/view/main/search/search_view.dart';
import 'package:foody_licious/presentation/view/authentication/login_view.dart';
import 'package:foody_licious/presentation/view/onboarding/onboarding_view.dart';
import 'package:foody_licious/presentation/view/authentication/signup_view.dart';
import 'package:foody_licious/presentation/view/onboarding/splash_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../cubit/navigation_cubit.dart';

class MainView extends StatefulWidget {
  const MainView({
    required this.menuScreenContext,
    this.navigationTabIndex = 0,
    final Key? key,
  }) : super(key: key);
  final BuildContext menuScreenContext;
  final int navigationTabIndex;

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late PersistentTabController _controller;
  late bool _hideNavBar;
  final List<ScrollController> _scrollControllers = [
    ScrollController(),
    ScrollController(),
  ];

  NavBarStyle _navBarStyle = NavBarStyle.style9;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  @override
  void dispose() {
    for (final element in _scrollControllers) {
      element.dispose();
    }
    super.dispose();
  }

  List<Widget> _buildScreens() =>
      [HomeView(), CartView(), SearchView(), OrderHistoryView(), ProfileView()];

  Color? _getSecondaryItemColorForSpecificStyles() =>
      _navBarStyle == NavBarStyle.style7 ||
              _navBarStyle == NavBarStyle.style10 ||
              _navBarStyle == NavBarStyle.style15 ||
              _navBarStyle == NavBarStyle.style16 ||
              _navBarStyle == NavBarStyle.style17 ||
              _navBarStyle == NavBarStyle.style18
          ? kWhite
          : null;

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: Image.asset(kHomeIcon),
          title: "Home",
          opacity: 0.7,
          activeColorPrimary: kTeal,
          activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
                  _navBarStyle == NavBarStyle.style10
              ? kWhite
              : null,
          inactiveColorPrimary: kGrey,
          scrollController: _scrollControllers.first,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: {
              "/first": (final context) => const HomeView(),
              "/second": (final context) => const HomeView(),
            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(kCartIcon),
          title: "Cart",
          activeColorPrimary: kTeal,
          inactiveColorPrimary: kGrey,
          activeColorSecondary: _getSecondaryItemColorForSpecificStyles(),
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(kSearchIcon),
          title: "Search",
          activeColorPrimary: kTeal,
          activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
                  _navBarStyle == NavBarStyle.style10
              ? kWhite
              : null,
          inactiveColorPrimary: kGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(kHistoryIcon),
          title: "History",
          activeColorPrimary: kTeal,
          inactiveColorPrimary: kGrey,
          activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
                  _navBarStyle == NavBarStyle.style10
              ? kWhite
              : null,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(kProfileIcon),
          title: "Profile",
          activeColorPrimary: kTeal,
          inactiveColorPrimary: kGrey,
          activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
                  _navBarStyle == NavBarStyle.style10
              ? kWhite
              : null,
          scrollController: _scrollControllers.last,
        ),
      ];

  @override
  Widget build(final BuildContext context) {
    return BlocListener<NavigationCubit, int>(
      listener: (context, tabIndex) {
        _controller.jumpToTab(tabIndex); // 🔁 Whenever cubit emits, switch tab
      },
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: false,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,
        hideOnScrollSettings: HideOnScrollSettings(
          hideNavBarOnScroll: true,
          scrollControllers: _scrollControllers,
        ),
        // floatingActionButton: IconButton(
        //   icon: Container(
        //     padding: const EdgeInsets.all(10),
        //     decoration: const BoxDecoration(
        //         shape: BoxShape.circle, color: Color(0xFF9CCD4F)),
        //     child: Image.asset('assets/icons/notification_text.png'),
        //   ),
        //   onPressed: () {},
        // ),
        onWillPop: (final context) async {
          await showDialog(
            context: context ?? this.context,
            useSafeArea: true,
            builder: (final context) => Container(
              height: 50,
              width: 50,
              color: kWhite,
              child: ElevatedButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
          return false;
        },
        // selectedTabScreenContext: (final context) {
        //   testContext = context;
        // },
        backgroundColor: kWhite,
        isVisible: !_hideNavBar,
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            duration: Duration(milliseconds: 300),
            screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
          ),
          onNavBarHideAnimation: OnHideAnimationSettings(
            duration: Duration(milliseconds: 100),
            curve: Curves.bounceInOut,
          ),
        ),
        confineToSafeArea: true,
        navBarHeight: 64.h,
        navBarStyle:
            _navBarStyle, // Choose the nav bar style with this property
      ),
    );
  }
}
