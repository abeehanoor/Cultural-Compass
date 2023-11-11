import 'package:cultural_app/dashboard_module/saved_places/saved_places.dart';
import 'package:cultural_app/values/my_colors.dart';
import 'package:cultural_app/values/my_imgs.dart';
import 'package:cultural_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/controllers/home_controller/home_controller.dart';
import '../../widgets/toasts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            CustomTextField(
                text: "Search by City or State",
                length: 30,
                textColor: MyColors.bodyBackground,
                suffixIcon: GestureDetector(
                    onTap: () async {
                      if (controller.text.isEmpty) {
                        CustomToast.failToast(msg: "Please provide city name");
                      } else {
                        Get.to(() => SavedPlaces(
                              search: controller.text,
                              appBarText: controller.text,
                            ));
                        await Get.find<HomeController>()
                            .searchCitites(controller.text);
                        controller.clear();
                      }
                    },
                    child: Icon(Icons.search)),
                keyboardType: TextInputType.text,
                background: MyColors.black,
                controller: controller,
                roundCorner: 18,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            SizedBox(
              height: 10.h,
            ),
            Obx(
              () => Get.find<HomeController>().isCitiesLoad.value
                  ? SizedBox(
                      height: 20.h,
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              Get.to(() => SavedPlaces(
                                    search: Get.find<HomeController>()
                                        .citiesModel
                                        .data[index],
                                appBarText: Get.find<HomeController>()
                                    .citiesModel
                                    .data[index],
                                  ));
                              await Get.find<HomeController>().searchCitites(
                                  Get.find<HomeController>()
                                      .citiesModel
                                      .data[index]);
                              controller.clear();
                            },
                            child: Text(
                              Get.find<HomeController>()
                                  .citiesModel
                                  .data[index],
                              style: textTheme.bodySmall!
                                  .copyWith(color: MyColors.black),
                            ),
                          );
                        },
                        itemCount:
                            Get.find<HomeController>().citiesModel.data.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 23.w,
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "or",
              style: textTheme.bodySmall!.copyWith(),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Click on the image to get all provinces cities ",
              style: textTheme.headlineSmall!.copyWith
                (color:Colors.black,),textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40.h,
            ),
             GestureDetector(
               onTap: () async {
                 Get.to(() => SavedPlaces(
                   search: "",
                   appBarText: "All Places",
                 ));
                 await Get.find<HomeController>()
                     .searchCitites(controller.text);
               },

                 child: Image.asset(MyImgs.pakMap)),
          ],
        ),
      ),
    );
  }
}
