import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/view/home_view.dart';
import 'package:foody_licious/view/pre_auth/login_view.dart';
import 'package:foody_licious/view/pre_auth/onboarding_view.dart';
import 'package:foody_licious/view/pre_auth/signup_view.dart';
import 'package:foody_licious/view/pre_auth/splash_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ProvidedStylesExample extends StatefulWidget {
  const ProvidedStylesExample({
    required this.menuScreenContext,
    final Key? key,
  }) : super(key: key);
  final BuildContext menuScreenContext;

  @override
  _ProvidedStylesExampleState createState() => _ProvidedStylesExampleState();
}

class _ProvidedStylesExampleState extends State<ProvidedStylesExample> {
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

  List<Widget> _buildScreens() => [
    HomeView(),
    SplashView(),
    LoginView(),
    SignUpView(),
    OnboardingView()
  ];

  Color? _getSecondaryItemColorForSpecificStyles() =>
      _navBarStyle == NavBarStyle.style7 ||
          _navBarStyle == NavBarStyle.style10 ||
          _navBarStyle == NavBarStyle.style15 ||
          _navBarStyle == NavBarStyle.style16 ||
          _navBarStyle == NavBarStyle.style17 ||
          _navBarStyle == NavBarStyle.style18
          ? Colors.white
          : null;

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon: Image.asset("assets/icons/home.png"),
      title: "Home",
      textStyle: GoogleFonts.lato(color: Color(0xFF09051C),fontSize: 12,fontWeight: FontWeight.normal),
      opacity: 0.7,
      activeColorPrimary: Colors.blue,
      activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
          _navBarStyle == NavBarStyle.style10
          ? Colors.white
          : null,
      inactiveColorPrimary: Colors.grey,
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
      icon: Image.asset("assets/icons/cart.png"),
      title: "Cart",
      activeColorPrimary: Colors.blueAccent,
      inactiveColorPrimary: Colors.grey,
      activeColorSecondary: _getSecondaryItemColorForSpecificStyles(),
    ),
    PersistentBottomNavBarItem(
      icon: Image.asset("assets/icons/search.png"),
      title: "Search",
      activeColorPrimary: Colors.teal,
      activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
          _navBarStyle == NavBarStyle.style10
          ? Colors.white
          : null,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Image.asset("assets/icons/history.png"),
      title: "History",
      activeColorPrimary: Colors.deepOrange,
      inactiveColorPrimary: Colors.grey,
      activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
          _navBarStyle == NavBarStyle.style10
          ? Colors.white
          : null,
    ),
    PersistentBottomNavBarItem(
      icon: Image.asset("assets/icons/profile.png"),
      title: "Profile",
      activeColorPrimary: Colors.indigo,
      inactiveColorPrimary: Colors.grey,
      activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
          _navBarStyle == NavBarStyle.style10
          ? Colors.white
          : null,
      scrollController: _scrollControllers.last,
    ),
  ];

  @override
  Widget build(final BuildContext context) =>  PersistentTabView(
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
      floatingActionButton: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xFF9CCD4F)),
          child: Image.asset('assets/icons/notification_text.png'),
        ),
        onPressed: () {},
      ),
      onWillPop: (final context) async {
        await showDialog(
          context: context ?? this.context,
          useSafeArea: true,
          builder: (final context) => Container(
            height: 50,
            width: 50,
            color: Colors.white,
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
      backgroundColor: Colors.white,
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
          screenTransitionAnimationType:
          ScreenTransitionAnimationType.fadeIn,
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
    );
}