import 'package:cultural_app/dashboard_module/edit_profile/edit_profile_screen.dart';
import 'package:cultural_app/values/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/controllers/home_controller/home_controller.dart';
import '../../values/my_colors.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GetBuilder<HomeController>(builder: (homeController) {
            return Column(
              children: [
                Image.asset(MyImgs.profileCurve),
                SizedBox(
                  height: 90.h,
                ),
                Text(
                  Get.find<HomeController>().userModel.data.name,
                  style: textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 18.sp),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "${Get.find<HomeController>().userModel.data.dateOfBirth} ${Get.find<HomeController>().userModel.data.bio == null ? "" : "|"} ${Get.find<HomeController>().userModel.data.bio ?? ""}",
                  style: textTheme.bodySmall,
                ),
                SizedBox(
                  height: 15.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(EditProfileScreen());
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 11.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: MyColors.black),
                    child: Text(
                      "Edit profile",
                      style: textTheme.bodyMedium!.copyWith(
                          color: MyColors.textColor2, fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            );
          }),
          Positioned(
            top: 150.h,
            child: Container(
              height: 125.h,
              width: 125.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(MyImgs.avatar))),
            ),
          )
        ],
      ),
    );
  }
}
