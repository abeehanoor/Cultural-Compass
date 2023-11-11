import 'package:cultural_app/values/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../values/my_colors.dart';
import '../../widgets/app_bar_widget.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: HelpingWidgets().appBarWidget(text: "Information", () {
        Get.back();
      }, color: MyColors.primaryColor),
      body: Column(
        children: [
          Image.asset(MyImgs.karachiPic),
          Image.asset(MyImgs.karachiPicReverse),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 29.w),
            child: Text(
              "Pakistan Cultural Compass is your interactive guide to the diverse cultural landscape of Pakistan. Dive deep into local languages, traditions, arts, and cuisine. Engage in enriching community dialogues and learn from unique insights shared by contributors across the country. Embark on this digital journey and celebrate Pakistan's cultural diversity at your fingertips.",
              style: textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 20.sp),
            ),
          )
        ],
      ),
    );
  }
}
