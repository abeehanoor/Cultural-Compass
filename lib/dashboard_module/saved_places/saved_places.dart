import 'package:cultural_app/data/controllers/home_controller/home_controller.dart';
import 'package:cultural_app/values/my_colors.dart';
import 'package:cultural_app/values/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/app_bar_widget.dart';

class SavedPlaces extends StatelessWidget {
  SavedPlaces({Key? key, required this.search,required this.appBarText}) : super(key: key);
  String search;
  String appBarText;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: HelpingWidgets().appBarWidget(() {
        Get.back();
      }, text: appBarText, color: MyColors.primaryColor),
      body: GetBuilder<HomeController>(builder: (homeController) {
        return homeController.myCitiesModel.data.isEmpty
            ? const Center(
                child: Text("Nothing found"),
              )
            : Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemBuilder: (context, index) {
                      return Container(
                        //color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 185.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: homeController.myCitiesModel
                                              .data[index].image ==
                                          null
                                      ? const DecorationImage(
                                          image: AssetImage(
                                            MyImgs.badshahi,
                                          ),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: NetworkImage(homeController
                                              .myCitiesModel
                                              .data[index]
                                              .image!),
                                          fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    homeController.myCitiesModel.data[index].destination,
                                    style: textTheme.bodyLarge!
                                        .copyWith(fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis),
                                    maxLines: 1,

                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (homeController.myCitiesModel.data[index]
                                        .isFavourite) {
                                      homeController.removeFav(
                                         name: search,
                                         id: homeController
                                              .myCitiesModel.data[index].id);
                                    } else {
                                      homeController.addFav(
                                      name:    search,
                                       id:   homeController
                                              .myCitiesModel.data[index].id);
                                    }
                                  },
                                  child: Image.asset(
                                    MyImgs.bookMarkFill,
                                    scale: 4,
                                    color: homeController.myCitiesModel
                                                .data[index].isFavourite ==
                                            false
                                        ? Colors.white
                                        : Colors.yellow,
                                  ),
                                )
                              ],
                            ),
                            // Text(
                            //   homeController.myCitiesModel.data[index].,
                            //   style: textTheme.titleMedium!.copyWith(
                            //       fontWeight: FontWeight.w500,
                            //       color: MyColors.redColor),
                            // ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              homeController
                                  .myCitiesModel.data[index].description,
                              style: textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.black.withOpacity(0.6)),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: homeController.myCitiesModel.data.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20.h,
                      );
                    },
                  ))
                ],
              );
      }),
    );
  }
}
