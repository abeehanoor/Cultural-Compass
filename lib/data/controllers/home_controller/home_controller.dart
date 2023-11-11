import 'package:cultural_app/auth_module/login/login.dart';
import 'package:cultural_app/data/models/my_citites_model/my_cities_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../values/constants.dart';
import '../../../widgets/toasts.dart';
import '../../GetServices/CheckConnectionService.dart';
import '../../models/cities_model/cities_model.dart';
import '../../models/user_model/user_model.dart';
import '../../repos/home_repo/home_repo.dart';

class HomeController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  HomeRepo homeRepo;

  HomeController({required this.homeRepo, required this.sharedPreferences});
  CheckConnectionService connectionService = CheckConnectionService();
  UserModel userModel = UserModel(
      status: Constants.noData,
      message: Constants.noData,
      data: Data(
          id: Constants.noData,
          name: Constants.noData,
          email: Constants.noData,
          otpVerify: false,
          city: null,
          dateOfBirth: Constants.noData,
          emailVerifiedAt: null,bio: null));

  var isUserDataLoaded = false.obs;
  var isCitiesLoad = false.obs;
  ProvincesModel citiesModel = ProvincesModel(
      status: Constants.noData, message: Constants.noData, data: []);
  MyCitiesModel myCitiesModel = MyCitiesModel(
      status: Constants.noData, message: Constants.noData, data: []);

  getUser() {
    isUserDataLoaded.value = false;
    connectionService.checkConnection().then((value) async {
      if (!value) {
        CustomToast.failToast(msg: "No Internet Connection".tr);
        // Get.back();
      } else {
        await homeRepo
            .getUser(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          Get.log("user response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              userModel = UserModel.fromJson(response.body);
              update();
              isUserDataLoaded.value = true;
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  getCities() {
    isCitiesLoad.value=false;
    connectionService.checkConnection().then((value) async {
      if (!value) {
        CustomToast.failToast(msg: "No Internet Connection".tr);
        // Get.back();
      } else {
        await homeRepo
            .getCities(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          Get.log("user response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              if (response.body["message"] == "Unauthorized") {
                sharedPreferences.remove(Constants.fullName);
                sharedPreferences.remove(Constants.email);
                sharedPreferences.remove(Constants.accessToken);
                sharedPreferences.remove(Constants.login);
                sharedPreferences.remove(Constants.userUid);

                Get.offAll(() => Login());
              }
            } else if (response.body["status"] == Constants.success) {
              citiesModel = ProvincesModel.fromJson(response.body);
              isCitiesLoad.value=true;
              update();
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  getFavorite() {
    connectionService.checkConnection().then((value) async {
      if (!value) {
        CustomToast.failToast(msg: "No Internet Connection".tr);
        // Get.back();
      } else {
        await homeRepo
            .getFavRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          Get.log("user response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              if (response.body["message"] == "Unauthorized") {
                Get.offAll(() => Login());
              }
            } else if (response.body["status"] == Constants.success) {
              myCitiesModel = MyCitiesModel.fromJson(response.body);
              update();
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  updateProfile(String name, String city, String bio) {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "No Internet Connection".tr);
        // Get.back();
      } else {
        await homeRepo.updateUser(
            formData: {"name": name, "city": city, "bio": bio},
            accessToken: sharedPreferences.getString(Constants.accessToken) ??
                "").then((response) async {
          Get.back();
          Get.log("login api response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              CustomToast.successToast(msg: response.body["message"]);
              getUser();
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  addFav({required String id, required String name}) {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "No Internet Connection".tr);
        // Get.back();
      } else {
        await homeRepo.addFavRepo(
            body: {"city_id": id},
            accessToken: sharedPreferences.getString(Constants.accessToken) ??
                "").then((response) async {
          Get.back();

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              CustomToast.successToast(msg: "Added successfully");
              if (name == "myFavourite") {
                getFavorite();
              } else {
                searchCitites(name);
              }
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  removeFav({required String name, required String id}) {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "No Internet Connection".tr);
        // Get.back();
      } else {
        await homeRepo.removeFavRepo(
            body: {
              "favorite_id": id,
            },
            accessToken: sharedPreferences.getString(Constants.accessToken) ??
                "").then((response) async {
          Get.back();
          Get.log("login api response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              CustomToast.successToast(msg: "Removed successfully");
              if (name == "myFavourite") {
                getFavorite();
              } else {
                searchCitites(name);
              }
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  searchCitites(String name) {
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "No Internet Connection".tr);
        // Get.back();
      } else {
        await homeRepo
            .searchCities(
                city: name,
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          Get.log("login api response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              myCitiesModel = MyCitiesModel.fromJson(response.body);
              update();
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getUser();
    getCities();
    super.onInit();
  }
}
