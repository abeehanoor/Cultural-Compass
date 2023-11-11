import 'package:cultural_app/widgets/custom_button.dart';
import 'package:cultural_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../../widgets/app_bar_widget.dart';

class ReportAProblem extends StatelessWidget {
  const ReportAProblem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: HelpingWidgets().appBarWidget(text: "Information", () {
        Get.back();
      }, color: MyColors.primaryColor),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 57.w),
        child: Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            CustomTextField(
                text: "Please provide as much info as possible...",
                length: 10000,
                roundCorner: 0,
                height: 313.h,
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              text: "Send report",
              onPressed: () {},
              roundCorner: 0,
              color: MyColors.black.withOpacity(0.25),
              width: 150.w,
              height: 40.h,
              textColor: MyColors.black,
            )
          ],
        ),
      ),
    );
  }
}
