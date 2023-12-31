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
import '../login/login.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword();

  final controller = Get.find<AuthController>();
  TextEditingController pwd = TextEditingController();
  TextEditingController confirmPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: MyColors.bodyBackground,
        appBar: HelpingWidgets().appBarWidget(() {
          Get.offAll(Login());
        }),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Dimens.size40.h,
                ),
                Center(
                  child: Text(
                    "Reset Password".tr,
                    style: textTheme.headline1!.copyWith(
                        color: MyColors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: Dimens.size30.h,
                ),
                SizedBox(
                  height: 124,
                  child: Image.asset(
                    MyImgs.logoFill,
                    color: MyColors.primaryColor,
                  ),
                ),
                SizedBox(
                  height: Dimens.size50.h,
                ),
                Center(
                  child: Text(
                    "Your new password must be different from previous password"
                        .tr,
                    style: textTheme.bodyText2!.copyWith(
                        color: MyColors.textColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: Dimens.size30.h,
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
                    //     offset:
                    //         Offset(0.0, 2.0), // shadow direction: bottom right
                    //   )
                    // ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: CustomTextField(
                        text: "Enter Password".tr,
                        controller: pwd,
                        textColor: MyColors.black,
                        //hintColor: MyColors.black,
                        background: MyColors.textFieldColor,
                        length: 35,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter),
                  ),
                ),
                SizedBox(
                  height: Dimens.size20.h,
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
                    //     offset:
                    //         Offset(0.0, 2.0), // shadow direction: bottom right
                    //   )
                    // ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: CustomTextField(
                        text: "Confirm password".tr,
                        controller: confirmPwd,
                        // hintColor: MyColors.black,
                        background: MyColors.textFieldColor,
                        length: 35,
                        textColor: MyColors.black,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter),
                  ),
                ),
                SizedBox(
                  height: Dimens.size30.h,
                ),
                Center(
                  child: CustomButton(
                      height: 48.h,
                      width: 280.w,
                      roundCorner: 30,

                      text: 'Reset Password'.tr,
                      onPressed: () {
                        if (pwd.text == confirmPwd.text) {
                          if (pwd.text == "") {
                            CustomToast.failToast(
                                msg: "Password fields can't be empty".tr);
                          } else {
                            if (pwd.text.length < 8) {
                              CustomToast.failToast(
                                  msg:
                                      "Password must be at least 8 characters long"
                                          .tr);
                            } else {
                              Get.find<AuthController>()
                                  .updatePassword(pwd.text);
                            }
                          }
                        } else {
                          CustomToast.failToast(
                              msg: "Both Passwords must be same".tr);
                        }
                        // Get.offAll(() => Login());

                        // Get.dialog(ProgressBar());
                        // controller.forgotPassword();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
