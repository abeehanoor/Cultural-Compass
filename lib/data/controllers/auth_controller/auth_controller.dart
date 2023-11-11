import 'dart:io';

import 'package:cultural_app/auth_module/email_verification/otp_screen.dart';
import 'package:cultural_app/auth_module/login/login.dart';
import 'package:cultural_app/dashboard_module/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:cultural_app/data/models/sign_up_model/sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth_module/forgot_password/resetPassword.dart';
import '../../../values/constants.dart';
import '../../../widgets/toasts.dart';
import '../../GetServices/CheckConnectionService.dart';
import '../../Repos/auth_repo/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  AuthRepo authRepo;
  CheckConnectionService connectionService = CheckConnectionService();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  bool isResendOtp = false;
  bool isLoggedIn = false;
  bool isRegisterAsSeller = false;
  bool isIndividual = true;

  bool timeOut = false;
  var mainContainer = 0.obs;
  var secondContainer = 0.obs;
  bool signUpObscure = true;
  File? idFront;
  File? idBack;
  DateTime? expiry;
  DateTime? issue;
  var maxPhoneLength = 10.obs;
  dynamic guestData;

  bool isGuest = false;
  var openingTime = "".obs;
  var closingTime = "".obs;

  var openingTime24h = "".obs;
  var closingTime24h = "".obs;
  // TimeOfDay? closingTime;
  TextEditingController name = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController profEmail = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController companyId = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController lng = TextEditingController();
  TextEditingController lat = TextEditingController();
  TextEditingController addBio = TextEditingController();
  // TextEditingController openingTime = TextEditingController();
  // TextEditingController closingTime = TextEditingController();
  TextEditingController issueDate = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  List<File?> farmImages = [];
  List<File?> farmImages2 = [];

  File? image;

  int i = 1;
  var imagePath = "".obs;
  var farmImagePath1 = "".obs;
  var farmImagePath2 = "".obs;
  var farmImagePath3 = "".obs;
  var farmImagePath4 = "".obs;
  var farmImagePath5 = "".obs;

  RxString timerText = "".obs;

  bool loginMode = true;

  AuthController({required this.authRepo, required this.sharedPreferences});

  signUp() async {
    await connectionService.checkConnection().then((value) async {
      if (!value) {
        CustomToast.failToast(msg: "noInternetConnection".tr);
        Get.back();
      } else {
        Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false);

        await authRepo.signUpUserRepo(formData: {
          "name": name.text,
          "email": email.text,
          "password": password.text,
          "password_confirmation": password.text,
          "date_of_birth": dateOfBirth.text
        }).then((response) {
          Get.log("response 111   ${response.body}");
          Get.back();
          if (response.statusCode == 200) {
            // Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              // SignUpModel model = SignUpModel.fromJson(response.body);
              if (response.body["data"]["next"] == "otp") {
                Get.to(() => OtpScreen(
                      isFromReset: false,
                      email: email.text,
                    ));
              }
              // {
              //   sharedPreferences.setString(Constants.userUid, model.data.id);
              //   sharedPreferences.setString(Constants.email, model.data.email);
              //   Get.offAll(() => BottomBarScreen());
              // }
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  login(String email, String password) {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "No internet Connection".tr);
        // Get.back();
      } else {
        await authRepo
            .loginRepo(formData: {"email": email, "password": password}).then(
                (response) async {
          Get.back();
          Get.log("login api response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              SignUpModel model = SignUpModel.fromJson(response.body);
              if (model.data.user.otpVerify) {
                CustomToast.successToast(msg: response.body["message"]);
                sharedPreferences.setString(
                    Constants.userUid, model.data.user.id);
                sharedPreferences.setString(
                    Constants.email, model.data.user.email);
                sharedPreferences.setString(
                    Constants.fullName, model.data.user.name);
                sharedPreferences.setString(
                    Constants.accessToken, model.data.accessToken);
                sharedPreferences.setBool(Constants.login, true);
                Get.to(() => BottomBarScreen());
              } else {
                Get.to(() => OtpScreen(
                      email: email,
                      isFromReset: false,
                    ));
              }
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  forgotPassword(String email) {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "noInternetConnection".tr);
        // Get.back();
      } else {
        await authRepo
            .forgotPassword(formData: {"email": email}).then((response) async {
          Get.back();
          Get.log("login api response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              Get.to(() => OtpScreen(
                    email: email,
                    isFromReset: true,
                  ));
              CustomToast.successToast(
                  msg: "Otp send successfully\nPlease check your email");
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  resendOtp(String email) {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "noInternetConnection".tr);
        // Get.back();
      } else {
        await authRepo
            .resendOtpRepo(formData: {"email": email}).then((response) async {
          Get.back();
          Get.log("login api response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              CustomToast.successToast(
                  msg: "Otp send successfully\nPlease check your email");
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  updatePassword(String password) {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "noInternetConnection".tr);
        // Get.back();
      } else {
        await authRepo.updatePasswordRepo(
            formData: {"password": password, "password_confirmation": password},
            accessToken: sharedPreferences.getString(Constants.accessToken) ??
                "").then((response) async {
          Get.back();
          Get.log("login api response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              Get.back();
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              SignUpModel model = SignUpModel.fromJson(response.body);
              if (model.status == Constants.success) {
                CustomToast.successToast(msg: "Password updated successfully");
                sharedPreferences.setString(
                    Constants.userUid, model.data.user.id);
                sharedPreferences.setString(
                    Constants.email, model.data.user.email);
                sharedPreferences.setString(
                    Constants.fullName, model.data.user.name);
                sharedPreferences.setString(
                    Constants.accessToken, model.data.accessToken);
                sharedPreferences.setBool(Constants.login, true);
                Get.to(() => BottomBarScreen());
              }
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  //
  // logout() {
  //   var token = sharedPreferences.getString(Constants.accessToken);
  //   if (token != null) {
  //     debugPrint(" => Access Token :$token");
  //     Get.dialog(Center(child: CircularProgressIndicator()),
  //         barrierDismissible: false);
  //     connectionService.checkConnection().then((value) async {
  //       if (!value) {
  //         Get.back();
  //         CustomToast.failToast(msg: "noInternetConnection".tr);
  //       } else {
  //         await authRepo.logout(accessToken: token).then((response) {
  //           Get.back();
  //           if (response.statusCode == 200) {
  //             // Get.back();
  //             if (response.body["status"] == "0") {
  //               CustomToast.failToast(
  //                   msg: response.body["message"] +
  //                       "\n" +
  //                       response.body["error"]);
  //             } else if (response.body["status"] != "0") {
  //               // debugPrint(model.data!.accessToken.toString());
  //               if (response.body["status"] == "1") {
  //                 sharedPreferences.remove(Constants.accessToken);
  //                 sharedPreferences.remove(Constants.userId);
  //                 sharedPreferences.remove(Constants.lastName);
  //                 sharedPreferences.remove(Constants.firstName);
  //                 bool isguest =
  //                     sharedPreferences.getBool(Constants.isGuest) ?? true;
  //                 sharedPreferences.clear();
  //                 sharedPreferences.setBool(Constants.isGuest, isguest);
  //                 sharedPreferences.setBool('isFirstTime', false);
  //                 isLoggedIn = false;
  //                 Get.offAll(() => Login());
  //               }
  //             }
  //           } else {
  //             CustomToast.failToast(
  //                 msg:
  //                     response.body["message"] + "\n" + response.body["error"]);
  //           }
  //         });
  //       }
  //     });
  //   } else {
  //     CustomToast.failToast(msg: "You are not Logged in.");
  //   }
  // }

  //

  clearLocalStorage() {
    sharedPreferences.clear();
    CustomToast.successToast(msg: "Log out successfully");
    Get.offAll(()=>Login());
  }

  verifyEmail({
    required String otp,
    required String email,
  }) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();
        CustomToast.failToast(msg: "noInternetConnection".tr);
      } else {
        await authRepo.verifyEmail(formData: {"otp": otp, "email": email}).then(
            (response) async {
          Get.back();
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              SignUpModel model = SignUpModel.fromJson(response.body);
              if (model.status == Constants.success) {
                CustomToast.successToast(msg: response.body["message"]);
                sharedPreferences.setString(
                    Constants.userUid, model.data.user.id);
                sharedPreferences.setString(
                    Constants.email, model.data.user.email);
                sharedPreferences.setString(
                    Constants.fullName, model.data.user.name);
                sharedPreferences.setString(
                    Constants.accessToken, model.data.accessToken);
                sharedPreferences.setBool(Constants.login, true);
                Get.to(() => BottomBarScreen());
              }
            } else {
              CustomToast.failToast(
                  msg: "Some Error has occured, Try Again Later");
            }
          }
        });
      }
    });
  }

  resetPasswordEmailVerify({
    required String otp,
    required String email,
  }) async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();
        CustomToast.failToast(msg: "noInternetConnection".tr);
      } else {
        await authRepo.verifyEmailResetPassword(
            formData: {"otp": otp, "email": email}).then((response) async {
          Get.back();
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              SignUpModel model = SignUpModel.fromJson(response.body);
              if (model.status == Constants.success) {
                CustomToast.successToast(msg: response.body["message"]);
                sharedPreferences.setString(
                    Constants.userUid, model.data.user.id);
                sharedPreferences.setString(
                    Constants.email, model.data.user.email);
                sharedPreferences.setString(
                    Constants.fullName, model.data.user.name);
                sharedPreferences.setString(
                    Constants.accessToken, model.data.accessToken);
                sharedPreferences.setBool(Constants.login, true);
                Get.to(() => ResetPassword());
              }
            } else {
              CustomToast.failToast(
                  msg: "Some Error has occured, Try Again Later");
            }
          }
        });
      }
    });
  }

  // resetPassword({
  //   required String password,
  //   required String otp,
  // }) {
  //   connectionService.checkConnection().then((value) async {
  //     Get.dialog(const Center(child: CircularProgressIndicator()),
  //         barrierDismissible: false);
  //     if (!value) {
  //       Get.back();
  //       CustomToast.failToast(msg: "noInternetConnection".tr);
  //     } else {
  //       await authRepo
  //           .changePasswordRepo(
  //         email: sharedPreferences.getString(Constants.userId)!,
  //         password: password,
  //         otp: otp,
  //         forgetRequestId:
  //             sharedPreferences.getString(Constants.forgetRequestId)!,
  //       )
  //           .then((response) {
  //         Get.back();
  //         if (response.statusCode == 200) {
  //           if (response.body["status"] == "0") {
  //             CustomToast.failToast(
  //                 msg:
  //                     response.body["message"] + "\n" + response.body["error"]);
  //             Get.back();
  //           } else if (response.body["status"] == "1") {
  //             CustomToast.successToast(
  //                 msg: response.body["message"] + response.body["error"]);
  //             Get.offAll(() => Login());
  //           }
  //         } else {
  //           CustomToast.failToast(
  //               msg: "Some Error has occured, Try Again Later");
  //         }
  //       });
  //     }
  //   });
  // }
  //
  // forgotPassword({required String email}) {
  //   Get.dialog(Center(child: CircularProgressIndicator()),
  //       barrierDismissible: false);
  //   connectionService.checkConnection().then((value) {
  //     if (!value) {
  //       Get.back();
  //       CustomToast.failToast(msg: "noInternetConnection".tr);
  //     } else {
  //       authRepo
  //           .forgotPasswordRepo(
  //         email: email,
  //       )
  //           .then((response) {
  //         Get.back();
  //         if (response.body["status"] == "0") {
  //           CustomToast.failToast(
  //               msg: response.body["message"] + "\n " + response.body["error"]);
  //         } else if (response.body["status"] != "0") {
  //           ApiResponse<ForgetPassRespModel> model = ApiResponse.fromJson(
  //               response.body, ForgetPassRespModel.fromJson);
  //           if (model.status == "1") {
  //             CustomToast.successToast(
  //                 msg: response.body["message"] + response.body["error"]);
  //             sharedPreferences.setString(Constants.userId, model.data!.userId);
  //             sharedPreferences.setString(
  //                 Constants.forgetRequestId, model.data!.forgetRequestId);
  //             Get.to(() => EmailVerification(
  //                   fromChangePass: true,
  //                 ));
  //           }
  //         }
  //         // ApiResponse model = ApiResponse.fromJson(
  //         //     response.body, ForgotPasswordResponse.fromJson);
  //         // if (model.status == "1") {
  //         //   CustomToast.successToast(msg: model.message + model.error);
  //         //   // Get.offAll(() => Login());
  //         // } else {
  //         //   CustomToast.failToast(msg: model.message + model.error);
  //         // }
  //       });
  //     }
  //   });
  // }
  //
  // guestUser(BuildContext context) {
  //   Get.dialog(Center(child: CircularProgressIndicator()),
  //       barrierDismissible: false);
  //   connectionService.checkConnection().then((value) async {
  //     if (!value) {
  //       Get.back();
  //       CustomToast.failToast(msg: "noInternetConnection".tr);
  //     } else {
  //       await getDeviceToken();
  //       authRepo
  //           .guestUser(
  //         deviceToken: sharedPreferences.getString(Constants.deviceToken) ?? "",
  //       )
  //           .then((response) async {
  //         Get.back();
  //         if (response.body["status"] == "0") {
  //           CustomToast.failToast(
  //               msg: response.body["message"] + "\n " + response.body["error"]);
  //         } else if (response.body["status"] != "0") {
  //           ApiResponse<GuestUser> model =
  //               ApiResponse.fromJson(response.body, GuestUser.fromJson);
  //           if (model.status == "1") {
  //             guestData = model.data!;
  //
  //             CustomToast.successToast(
  //                 msg:
  //                     response.body["message"] + "\n" + response.body["error"]);
  //             sharedPreferences.setString(
  //                 Constants.userId, model.data!.userId!);
  //             sharedPreferences.setString(
  //                 Constants.accessToken, model.data!.accessToken!);
  //             isGuest = true;
  //             sharedPreferences.setBool(Constants.isGuest, isGuest);
  //             // Get.find<LocationController>()
  //             //     .getCurrentLocation(context,updateLocation: true);
  //             await Get.find<HomeController>().getAllCategories();
  //             Get.find<HomeController>().homeCategoriesShimmer.value = true;
  //             Get.offAll(() => BottomBarScreen(
  //                   page: "guest",
  //                 ));
  //           }
  //         }
  //         // ApiResponse model = ApiResponse.fromJson(
  //         //     response.body, ForgotPasswordResponse.fromJson);
  //         // if (model.status == "1") {
  //         //   CustomToast.successToast(msg: model.message + model.error);
  //         //   // Get.offAll(() => Login());
  //         // } else {
  //         //   CustomToast.failToast(msg: model.message + model.error);
  //         // }
  //       });
  //     }
  //   });
  // }
  //
  // resendOtp() async {
  //   Get.dialog(const Center(child: CircularProgressIndicator()),
  //       barrierDismissible: false);
  //   await connectionService.checkConnection().then((value) async {
  //     if (!value) {
  //       Get.back();
  //       CustomToast.failToast(msg: "noInternetConnection".tr);
  //     } else {
  //       await authRepo
  //           .resendOtpRepo(
  //               email: sharedPreferences.getString(Constants.email) ?? "",
  //               userId: sharedPreferences.getString(Constants.userId) ?? "")
  //           .then((response) {
  //         Get.back();
  //         if (response.statusCode == 200) {
  //           // Get.back();
  //           if (response.body["status"] == "0") {
  //             CustomToast.failToast(
  //                 msg:
  //                     response.body["message"] + "\n" + response.body["error"]);
  //           } else if (response.body["status"] != "0") {
  //             // ApiResponse model = ApiResponse.fromJson(response.body, (p0) {});
  //             // if (model.status == "1") {
  //             CustomToast.successToast(
  //                 msg:
  //                     response.body["message"] + "\n" + response.body["error"]);
  //             // }
  //           }
  //         } else {
  //           CustomToast.failToast(
  //               msg: response.body["message"] + "\n" + response.body["error"]);
  //         }
  //       });
  //     }
  //   });
  // }
  //
  // sessionCheck(BuildContext context) async {
  //   Get.log("in splash session func");
  //   Get.log("guest value ${sharedPreferences.getBool(Constants.isGuest)}");
  //
  //   var token = sharedPreferences.getString(Constants.accessToken) ?? "";
  //   if (token != "") {
  //     authRepo
  //         .checkSessionRepo(
  //             accessToken: token,
  //             isGuest: sharedPreferences.getBool(Constants.isGuest) ?? false)
  //         .then((response) async {
  //       Get.log("in splash session func then ");
  //       if (response.statusCode == 200) {
  //         // Get.back();
  //         if (response.body["status"] == "0") {
  //           isGuest = true;
  //           sharedPreferences.setBool(Constants.isGuest, isGuest);
  //           // CustomToast.failToast(
  //           //     msg: response.body["message"] + response.body["error"]);
  //           // await Get.find<LocationController>()
  //           //     .getCurrentLocation(context,updateLocation: true);
  //           Get.to(() => ChooseProfilePage());
  //         } else if (response.body["status"] != "0") {
  //           // await Get.find<ProfileController>().getBusinessInfoData();
  //           ApiResponse<LoginResponseModel> model = ApiResponse.fromJson(
  //               response.body, LoginResponseModel.fromJson);
  //           if (model.status == "1") {
  //             isLoggedIn = true;
  //             // CustomToast.successToast(
  //             //     msg:
  //             //         response.body["message"] +  response.body["error"]);
  //             if (sharedPreferences.getString(Constants.accessToken) != null) {
  //               sharedPreferences.setString(
  //                   Constants.userImage, model.data!.image);
  //               sharedPreferences.setString(
  //                   Constants.userId, model.data!.userId);
  //               sharedPreferences.setString(Constants.email, model.data!.email);
  //               sharedPreferences.setString(
  //                   Constants.lastName, model.data!.lastName);
  //               sharedPreferences.setString(
  //                   Constants.firstName, model.data!.firstName);
  //
  //               await Future.wait([
  //                 Get.find<HomeController>().getHomeReviews(),
  //                 // Get.find<LocationController>()
  //                 //     .getCurrentLocation(context,updateLocation: true),
  //                 Get.find<HomeController>().getAllCategories(),
  //                 Get.find<ProfileController>().getProfileData(),
  //                 //  Get.find<HomeController>().getAllAppointmentByDate("","",DateTime.now().month.toString(),"showMonthly")
  //               ]);
  //               // await Future.wait([
  //               // Get.find<HomeController>().getHomeReviews(),
  //               // Get.find<LocationController>()
  //               //     .getCurrentLocation(updateLocation: true);
  //               // Get.find<HomeController>().getAllCategories(),
  //               // Get.find<ProfileController>().getProfileData(),
  //               // Get.find<HomeController>().getAllAppointmentByDate("",DateTime.now().month.toString(),"showMonthly")
  //               // ]);
  //               Get.find<HomeController>().homeCategoriesShimmer.value = true;
  //
  //               Get.find<HomeController>().getHomeReviewsData != null
  //                   ? Get.find<HomeController>()
  //                               .getHomeReviewsData!
  //                               .allApprovedAppointments
  //                               .isEmpty ||
  //                           Get.find<HomeController>().getHomeReviewsData ==
  //                               null
  //                       ? Get.offAll(() => BottomBarScreen(
  //                             page: "regular",
  //                           ))
  //                       : Get.offAll(() => SubmitRatings())
  //                   : Get.offAll(() => BottomBarScreen(page: "regular"));
  //             }
  //           }
  //         }
  //       } else {
  //         CustomToast.failToast(
  //             msg: response.body["message"] + "\n" + response.body["error"]);
  //       }
  //     });
  //   } else {
  //     isGuest = true;
  //     sharedPreferences.setBool(Constants.isGuest, isGuest);
  //     // CustomToast.failToast(
  //     //     msg: response.body["message"] + response.body["error"]);
  //     // await Get.find<LocationController>()
  //     //     .getCurrentLocation(context,updateLocation: true);
  //     Get.to(() => ChooseProfilePage());
  //   }
  // }
  //
  // createSeller() async {
  //   Get.dialog(const Center(child: CircularProgressIndicator()),
  //       barrierDismissible: false);
  //   await connectionService.checkConnection().then((value) async {
  //     if (!value) {
  //       Get.back();
  //       CustomToast.failToast(msg: "noInternetConnection".tr);
  //     } else {
  //       await authRepo
  //           .createSellerRepo(
  //               businessType: isIndividual ? "Individual" : "Company",
  //               businessName: businessName.text,
  //               streetAddress: streetAddress.text,
  //               city: city.text,
  //               zip: zip.text,
  //               country: country.text,
  //               businessEmail: profEmail.text,
  //               businessPhoneNum: phone.text,
  //               accessToken:
  //                   sharedPreferences.getString(Constants.accessToken)!,
  //               companyInfo: desc.text,
  //               companyID: isIndividual ? '' : companyId.text,
  //               // desc:
  //               // sellerImage: image!,
  //               lat: Get.find<LocationController>().address!.lat.toString(),
  //               lng: Get.find<LocationController>().address!.lng.toString(),
  //               openingTime: "${openingTime24h.value}",
  //               closingTime: "${closingTime24h.value}",
  //               desc: addBio.text)
  //           .then((response) {
  //         Get.back();
  //         if (response.statusCode == 200) {
  //           // Get.back();
  //           if (response.body["status"] == "0") {
  //             CustomToast.failToast(
  //                 msg:
  //                     response.body["message"] + "\n" + response.body["error"]);
  //           } else if (response.body["status"] != "0") {
  //             ApiResponse model = ApiResponse.fromJson(response.body, (p0) {});
  //             if (model.status == "1") {
  //               isRegisterAsSeller = true;
  //               CustomToast.successToast(
  //                   msg: response.body["message"] +
  //                       "\n" +
  //                       response.body["error"]);
  //               Get.to(() => IdentityVerification());
  //             }
  //           }
  //         } else {
  //           CustomToast.failToast(
  //               msg: response.body["message"] + "\n" + response.body["error"]);
  //         }
  //       });
  //     }
  //   });
  // }
  //
  // String? deviceToken;
  // Future<String?> getDeviceToken() async {
  //   await FirebaseMessaging.instance.getToken().then((token) {
  //     if (token != null) {
  //       deviceToken = token;
  //       sharedPreferences.setString(Constants.deviceToken, token);
  //       // GetLocalStorage().setToken(token);
  //       // guestUser();
  //       //  SingleToneValue.instance.deviceToken = token;
  //       print("Dv token $token");
  //     }
  //   }).catchError((onError) {
  //     print("the error is $onError");
  //   });
  //   return deviceToken;
  // }
}
