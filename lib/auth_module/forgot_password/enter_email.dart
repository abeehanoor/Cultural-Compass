import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../values/values.dart';
import '../../../widgets/custom_button.dart';
import '../../data/controllers/auth_controller/auth_controller.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/toasts.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  GlobalKey<FormState> emailFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: HelpingWidgets().appBarWidget(() {
            Get.back();
          }),
          backgroundColor: MyColors.bodyBackground,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.size36.w),
              child: Form(
                key: emailFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Dimens.size40.h,
                    ),
                    Text(
                      'Forgot Password?'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: Dimens.size32.sp,
                          color: MyColors.black),
                    ),
                    SizedBox(
                      height: (Dimens.size42).h,
                    ),
                    Image.asset(
                      MyImgs.logoFill,
                      scale: 4,
                    ),
                    SizedBox(
                      height: 92.h,
                    ),
                    Text(
                      'Please enter your email address to receive a verification code'
                          .tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: (Dimens.size16).sp,
                        color: MyColors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 31.h,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: MyColors.textFieldColor,
                        borderRadius: BorderRadius.circular(48),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.4),
                        //     blurRadius: 2.0,
                        //     spreadRadius: 0.0,
                        //     offset: Offset(
                        //         0.0, 2.0), // shadow direction: bottom right
                        //   )
                        // ],
                      ),
                      width: double.infinity,
                      child: CustomTextField(
                          height: 48.h,
                          icon: null,
                          controller: email,
                          text: "Enter email".tr,
                          background: MyColors.textFieldColor,
                          roundCorner: 30,
                          length: 50,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter),
                    ),
                    SizedBox(
                      height: Dimens.size60.h,
                    ),
                    CustomButton(
                      text: 'Send Code'.tr,
                      onPressed: () {
                        if (email.text.isEmpty || !email.text.isEmail) {
                          CustomToast.failToast(
                              msg: "Please enter valid data".tr);

                        } else {
                          authController.forgotPassword(email.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
