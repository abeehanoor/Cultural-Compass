import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../values/dimens.dart';
import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../drawer_screen/dwarer_screen.dart';
import '../home_screen/home_screen.dart';
import '../profile_screen/profile_screen.dart';

class BottomBarScreen extends StatefulWidget {
  int? index;
  BottomBarScreen({Key? key, this.index = 0}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  @override
  void initState() {
    super.initState();
  }

  // int _currentIndex = wi;
  final List<Widget> _widgetOption = [
     HomeScreen(),
    // Container(),
     ProfileScreen(),
  ];

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // drawer: MyDrawer(),
      backgroundColor: MyColors.primaryColor,
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,

      drawer: MyDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: MyColors.primaryColor),
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: Image.asset(
            MyImgs.drawerIcon,
            color: MyColors.black,
            scale: 4,
          ),
        ),
        title: Text(
          widget.index == 0 ? "Home" : "Profile",
          style: textTheme.headlineMedium!
              .copyWith(fontWeight: FontWeight.w500, fontSize: 22.sp),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              MyImgs.logoFill,
              scale: 4,
            ),
          )
        ],
        backgroundColor:
            widget.index == 0 ? MyColors.primaryColor : const Color(0xffB6E8D9),
        elevation: 0,
      ),

      body:
          // widget.index! > 0 && widget.page == "guest"
          //     ? Scaffold(
          //         body: GestureDetector(
          //           onTap: () {
          //             Get.to(() => SignUp());
          //           },
          //           child: Center(
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text("Please sign up to continue ".tr),
          //                 Text(
          //                   "Sign Up".tr,
          //                   style: TextStyle(color: MyColors.blue50),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       )
          //
          //     //CustomToast.failToast(msg: "Please sign up or log in to continue")
          //     :
          // CustomToast.failToast(msg: "in other index"),

          _widgetOption.elementAt(widget.index!),

      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(98.h),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              BottomNavigationBar(
                elevation: 0,
                backgroundColor: MyColors.bottomBar,
                currentIndex: widget.index!,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: MyColors.selectedBottomBarColor,
                unselectedItemColor: MyColors.bodyBackground,
                selectedFontSize: 12,
                unselectedFontSize: 10,
                selectedIconTheme:
                    IconThemeData(color: MyColors.selectedBottomBarColor),
                unselectedLabelStyle: TextStyle(
                  fontFamily: 'Poppins',
                ),
                selectedLabelStyle: TextStyle(
                  fontFamily: 'Poppins',
                ),
                items: [
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        MyImgs.homeFill,
                        scale: 4,
                      ),
                      label: ""),
                  //
                  // BottomNavigationBarItem(
                  //     icon: Image.asset(MyImgs.chatFill,scale: 4,),
                  //     label: ""),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        MyImgs.userFill,
                        scale: 4,
                      ),
                      label: ""),
                ],
                onTap: (value) async {
                  setState(() {
                    widget.index = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      //body: _widgetOption.elementAt(_currentIndex),
      // drawer: MyDrawer(),
      //
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   // isExtended: true,
      //   mini: false,
      //   elevation: 0,
      //   foregroundColor: MyColors.green,
      //   backgroundColor: MyColors.primaryColor,
      //   child: Material(
      //     // height: getHeight(200),
      //     type: MaterialType.transparency,
      //     child: Ink(
      //       decoration: BoxDecoration(
      //         border: Border.all(color: MyColors.bodyBackground, width: 5.0.w),
      //         shape: BoxShape.circle,
      //         color: MyColors.primary2,
      //       ),
      //       child: Center(
      //         child: Image.asset(
      //           MyImgs.logo3,
      //           width: 80.w,
      //           height: 80.w,
      //           fit: BoxFit.contain,
      //         ),
      //       ),
      //     ),
      //   ),
      //   onPressed: () async {},
      //   // label: null,
      // ),
    );
  }
}
