import 'package:cultural_app/data/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../values/dimens.dart';
import '../../../values/my_colors.dart';
import '../../../values/my_imgs.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/otp_fields.dart';
import '../sign_up_screen/sign_up_screen.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({required this.email, this.isFromReset = false});
  String email;
  bool isFromReset;

  @override
  State<OtpScreen> createState() => _OtpScreen();
}

class _OtpScreen extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onBack() {
    Get.offAll(() => SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    Get.log("email    ${widget.email}");
    return WillPopScope(
      onWillPop: (() => onBack()),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.bodyBackground,
            elevation: 0,
            // leading: IconButton(
            //   icon: Image.asset(
            //     MyImgs.back1,
            //     height: (Dimens.size22.h),
            //     width: (Dimens.size22.w),
            //     color: MyColors.black,
            //     fit: BoxFit.cover,
            //   ),
            //   onPressed: () => Get.back(),
            // ),
            centerTitle: true,
          ),
          backgroundColor: MyColors.bodyBackground,
          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Dimens.size20.h,
              ),
              SizedBox(
                height: 245.h,
                child: Image.asset(
                  MyImgs.otp_avatar,
                ),
              ),
              SizedBox(
                height: Dimens.size20.h,
              ),
              Center(
                child: Text(
                  "OTP Verification".tr,
                  style: textTheme.bodyLarge!.copyWith(
                      //fontFamily: "TiemposHeadline-Regular",

                      fontWeight: FontWeight.w700),
                ),
              ),
              Center(
                child: SizedBox(
                    width: mediaQuery.width * 0.8,
                    child: Text(
                      'We sent you one time password to your\nemail'.tr,
                      style: textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,

                        //fontFamily: "TiemposHeadline-Regular",
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
              SizedBox(
                height: Dimens.size50.h,
              ),
              CustomPinEntryField(
                //    decoration: InputDecoration(),
                keyboard: TextInputType.text,
                onSubmit: (otp) {
                  otpController.text = otp;
                  print(otpController.text);
                },
                textStyle: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: MyColors.black),
                fields: 6,

                fieldWidth: 42.w,
              ),
              // CustomTextField(
              //     text: "Enter Code",
              //     hintColor: MyColors.white.withOpacity(0.5),
              //     background: MyColors.textField.withOpacity(0.2),
              //     length: 35,
              //     keyboardType: TextInputType.emailAddress,
              //     inputFormatters:
              //         FilteringTextInputFormatter.singleLineFormatter),
              SizedBox(
                height: Dimens.size20.h,
              ),
              Container(
                child: Visibility(
                  visible: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn’t receive the OTP ?".tr,
                        style: textTheme.bodySmall!.copyWith(
                          color: MyColors.lightTextColor,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.find<AuthController>().resendOtp(widget.email);
                        },
                        child: Text(
                          " Resent OTP".tr,
                          style: textTheme.bodySmall!.copyWith(
                            color: MyColors.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Dimens.size80.h,
              ),
              CustomButton(
                  text: "Verify",
                  width: Dimens.size270.w,
                  onPressed: () async {
                    if (!widget.isFromReset) {
                      Get.find<AuthController>().verifyEmail(email:widget.email, otp: otpController.text);
                    } else {
                      Get.find<AuthController>().resetPasswordEmailVerify(
                          otp: otpController.text, email: widget.email);
                    }
                  })
            ],
          )),
        ),
      ),
    );
  }
}
