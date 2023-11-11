import 'package:cultural_app/widgets/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helper/validators.dart';
import '../../../values/constants.dart';
import '../../../values/my_colors.dart';
import '../../../values/my_imgs.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../data/controllers/auth_controller/auth_controller.dart';
import '../../data/controllers/home_controller/home_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  TextEditingController yourNameController = TextEditingController(
      text: Get.find<HomeController>().userModel.data.name);
  TextEditingController cityController = TextEditingController(
      text: Get.find<HomeController>().userModel.data.city ?? "");
  TextEditingController bioController = TextEditingController(text: Get.find<HomeController>().userModel.data.bio ?? "");

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: HelpingWidgets().appBarWidget(() {
        Get.back();
      }, text: "Edit Profile", color: MyColors.primaryColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 175.h,
                  width: 175.h,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                            MyImgs.avatar,
                          ),
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                "Name".tr,
                style: textTheme.titleLarge!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 11.h,
              ),
              CustomTextField(
                text: "Abeeha Shah",
                length: 500,
                height: 44.h,
                roundCorner: 6,
                textColor: MyColors.black,
                background: MyColors.primaryColor,
                bordercolor: MyColors.black.withOpacity(0.14),
                hintColor: MyColors.black.withOpacity(0.6),
                controller: yourNameController,
                keyboardType: TextInputType.emailAddress,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Your City/Region".tr,
                style: textTheme.titleLarge!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 11.h,
              ),
              CustomTextField(
                text: "Lahore",
                length: 500,
                height: 44.h,
                roundCorner: 6,
                textColor: MyColors.black,
                background: MyColors.primaryColor,
                bordercolor: MyColors.black.withOpacity(0.14),
                hintColor: MyColors.black.withOpacity(0.6),
                controller: cityController,
                keyboardType: TextInputType.emailAddress,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Bio (optional)".tr,
                style: textTheme.titleLarge!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 11.h,
              ),
              CustomTextField(
                text: "Travel enthusiast",
                length: 500,
                height: 44.h,
                roundCorner: 6,
                textColor: MyColors.black,
                background: MyColors.primaryColor,
                bordercolor: MyColors.black.withOpacity(0.14),
                hintColor: MyColors.black.withOpacity(0.6),
                controller: bioController,
                keyboardType: TextInputType.emailAddress,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(33.h),
        child: CustomButton(
          text: "Save",
          onPressed: () async {
            if (yourNameController.text.isEmpty) {
              CustomToast.failToast(msg: "Please provide name");
            } else {
              if (cityController.text.isEmpty) {
                CustomToast.failToast(msg: "Please provide city");
              } else {
                await Get.find<HomeController>().updateProfile(
                    yourNameController.text,
                    cityController.text,
                    bioController.text);
              }
            }
          },
          borderColor: MyColors.black,
          color: MyColors.black,
        ),
      ),
    );
  }
}
