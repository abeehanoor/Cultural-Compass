import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../values/dimens.dart';
import '../../../values/my_colors.dart';
import '../../../values/my_imgs.dart';
import '../../data/controllers/auth_controller/auth_controller.dart';
import '../../helper/validators.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/toasts.dart';
import '../forgot_password/enter_email.dart';
import '../sign_up_screen/sign_up_screen.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final GlobalKey<FormState> loginformKey = GlobalKey();

  // TextEditingController countryCode =
  final TextEditingController email = TextEditingController();

  final TextEditingController loginPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        //  appBar: HelpingWidgets().appBarWidget((){Get.back();}),
        //backgroundColor: MyColors.primaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.size33.w),
            child: Form(
              key: loginformKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimens.size130.h,
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
                    roundCorner: 16,

                    controller: email,
                    keyboardType: TextInputType.text,
                    validator: (value) => Validators.passwordValidator(value!),
                    text: "Email".tr,
                    length: 30,
                    // suffixIcon: GestureDetector(
                    //   child: Image.asset(
                    //     MyImgs.eye_on,
                    //     scale: 3.5,
                    //   ),
                    //   onTap: () {
                    //
                    //   },
                    // ),
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                    roundCorner: 16,
                    controller: loginPassword,
                    keyboardType: TextInputType.text,
                    validator: (value) => Validators.passwordValidator(value!),
                    text: "Password".tr,
                    length: 30,
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(()=>ForgotPassword());
                      },
                      child: Text(
                        "Forgot password",
                        style: textTheme.titleLarge!.copyWith(
                            color: MyColors.redColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  CustomButton(
                      text: "LOGIN NOW",
                      onPressed: () async {
                        if (!loginformKey.currentState!.validate()) {
                          CustomToast.failToast(
                              msg: "Please provide all necessary information");
                        } else {
                          if (email.text.isEmpty) {
                            CustomToast.failToast(msg: "Please provide email");
                          } else {
                            if (loginPassword.text.isEmpty) {
                              CustomToast.failToast(
                                  msg: "Please provide password");
                            } else {
                              if (!email.text.isEmail) {
                                CustomToast.failToast(
                                    msg: "Please provide valid email");
                              } else {
                                if (loginPassword.text.length < 8) {
                                  CustomToast.failToast(
                                      msg: "Password must be 8 characters");
                                } else {
                                  await Get.find<AuthController>()
                                      .login(email.text, loginPassword.text);
                                }
                              }
                            }
                          }
                        }
                      }),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account?  ",
                        style: textTheme.titleLarge!.copyWith(
                            color: MyColors.textColor,
                            fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.off(SignUpScreen());
                        },
                        child: Text(
                          "Create account",
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

      ),
    );
  }
}
