import 'package:cultural_app/data/Repos/auth_repo/auth_repo.dart';
import 'package:cultural_app/data/api_provider/api_provider.dart';
import 'package:cultural_app/data/controllers/auth_controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/controllers/home_controller/home_controller.dart';
import '../data/repos/home_repo/home_repo.dart';

Future init() async {
  Get.log("int di");
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiProvider());

  Get.lazyPut(() => AuthRepo(apiProvider: Get.find()));
  Get.lazyPut(() => HomeRepo(apiProvider: Get.find()));

  ///Controllers
  Get.lazyPut(() =>
      AuthController(authRepo: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() =>
      HomeController(homeRepo: Get.find(), sharedPreferences: sharedPreferences));
}
