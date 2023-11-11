import 'package:cultural_app/values/my_imgs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../values/constants.dart';
import '../values/dimens.dart';
import '../values/my_colors.dart';

class HelpingWidgets {
  PreferredSizeWidget appBarWidget(onTap, {String? text,Color? color}) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: color ?? MyColors.bodyBackground
      ),
      backgroundColor:color ?? MyColors.bodyBackground,
      leadingWidth: 70.w,
      elevation: 0,
      title: text != null
          ? Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  fontFamily: Constants.robotoFamily),
            )
          : null,
      centerTitle:color==null? true:false,
      leading:onTap==null?null: GestureDetector(
        onTap: onTap,
        child: Image.asset(MyImgs.expandRightDoubleClick,scale: 4,),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            MyImgs.logoFill,
            scale: 4,
          ),
        )
      ],
    );
  }

  Widget appBarText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
          //  fontStyle: FontStyle.normal,
          fontFamily: "Poppins"),
    );
  }
}
