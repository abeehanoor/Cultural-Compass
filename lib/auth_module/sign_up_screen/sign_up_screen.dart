import 'package:cultural_app/auth_module/login/login.dart';
import 'package:cultural_app/dashboard_module/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../values/constants.dart';
import '../../../values/my_colors.dart';
import '../../../values/my_imgs.dart';
import '../../data/controllers/auth_controller/auth_controller.dart';
import '../../helper/validators.dart';
import '../../values/dimens.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/toasts.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> signUpformKey = GlobalKey();
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: HelpingWidgets().appBarWidget(() {
        Get.off(Login());
      }),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: Form(
            key: signUpformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 41.h,
                ),
                Image.asset(
                  MyImgs.logoFill,
                  scale: 4,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "LOGIN NOW",
                  style: textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                      color: MyColors.primaryColor),
                ),
                SizedBox(
                  height: Dimens.size5.h,
                ),
                Text(
                  "Please enter email and password.",
                  style: textTheme.titleLarge!.copyWith(
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: Dimens.size32.h,
                ),
                CustomTextField(
                  text: "Enter your name",
                  length: 500,
                  controller: authController.name,
                  validator: (value) =>
                      Validators.firstNameValidation(value!.toString()),
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomTextField(
                  text: "DD / MM / YYYY",
                  length: 500,
                  Readonly: true,
                  controller: authController.dateOfBirth,
                  validator: (value) =>
                      Validators.firstNameValidation(value!.toString()),
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: GestureDetector(
                    child: Icon(
                      Icons.calendar_month,
                      color: MyColors.redColor,
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        firstDate: DateTime(1900),
                        initialDate: DateTime(2004),
                        context: context,
                        lastDate: DateTime(2004),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor:
                                  Colors.teal, // OK button background color
                              hintColor: Colors.teal, // OK button text color
                              dialogBackgroundColor:
                                  Colors.white, // Dialog background color
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        var data = picked.toIso8601String().split("T");
                        authController.dateOfBirth.text = data[0];
                        Get.log("date  ${data[0]}");
                      }
                    },
                  ),
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomTextField(
                  text: "Email",
                  length: 500,
                  controller: authController.email,
                  validator: (value) =>
                      Validators.emailValidator(value!.toString()),
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomTextField(
                  roundCorner: 16,
                  keyboardType: TextInputType.text,
                  validator: (value) => Validators.passwordValidator(value!),
                  text: "Password".tr,
                  length: 30,
                  controller: authController.password,
                  suffixIcon: GestureDetector(
                    child: Image.asset(
                      MyImgs.eye_on,
                      scale: 3.5,
                      color: MyColors.redColor,
                    ),
                    onTap: () {},
                  ),
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomButton(
                    text: "Sign up".tr,
                    onPressed: () async {
                      if (!signUpformKey.currentState!.validate()) {
                        CustomToast.failToast(
                            msg: "Please provide all necessary information");
                      } else {
                        if (Get.find<AuthController>().password.text.length <
                            8) {
                          CustomToast.failToast(
                              msg: "Password should be at least 8 characters");
                        } else if (!Get.find<AuthController>()
                            .email
                            .text
                            .isEmail) {
                          CustomToast.failToast(
                              msg: "Please provide valid email");
                        } else {
                          await Get.find<AuthController>().signUp();
                        }
                      }
                      // Get.offAll(() => OtpScreen());
                    }),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You have an account?  ",
                      style: textTheme.titleLarge!.copyWith(
                          color: MyColors.textColor,
                          fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.off(Login());
                      },
                      child: Text(
                        "Login now",
                        style: textTheme.titleLarge!.copyWith(
                            color: MyColors.redColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
