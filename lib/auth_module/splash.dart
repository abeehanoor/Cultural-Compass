import 'dart:async';

import 'package:cultural_app/dashboard_module/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:cultural_app/data/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../onboarding/onboarding_screen.dart';
import '../values/constants.dart';
import 'login/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();

    WidgetsBinding.instance.addObserver(this);
    Timer(const Duration(seconds: 2), () async {
      Get.find<AuthController>().sharedPreferences.get(Constants.login) ==
                  null ||
              Get.find<AuthController>()
                      .sharedPreferences
                      .get(Constants.login) ==
                  false
          ? Get.offAll(() => WalkThroughScreen())
          :
      Get.offAll(() => BottomBarScreen());
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Get.log("in app resume");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness:
          Brightness.dark, // this will change the brightness of the icons
      statusBarColor: MyColors.primaryColor, // or any color you want
    ));
    final mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    var height;
    setState(() {
      if (isLandScape) {
        height = mediaQuery.size.width;
      } else {
        height = mediaQuery.size.height;
      }
    });
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImgs.splashBackground), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 140.h,
            width: 147.w,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(MyImgs.logo), fit: BoxFit.contain)),
          ),
          SizedBox(
            height: 36.h,
          ),
          Text(
            "Cultural Compass",
            style: textTheme.headlineLarge!.copyWith(
                // fontSize: 32.sw,
                fontWeight: FontWeight.w700,
                color: MyColors.bodyBackground),
          )
          // Text(
          //   "Farm Sharing".tr,
          //   style: textTheme.headline4
          // )
        ],
      ),
    ));
  }
}
