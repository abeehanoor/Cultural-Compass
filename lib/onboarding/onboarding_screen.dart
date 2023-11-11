import 'package:cultural_app/auth_module/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../values/values.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _photos(
                      photo: MyImgs.lahorePic,
                      headline: "Welcome",
                      subtitle:
                          "Our app is a platform for discovering and exploring the rich cultural heritage of different regions around the Pakistan.",
                      photo2: MyImgs.lahorePicReverse),
                  _photos(
                      photo2: MyImgs.karachiPicReverse,
                      photo: MyImgs.karachiPic,
                      headline: "About Us",
                      subtitle:
                          "Cultural compass was created with the aim of promoting cultural heritage tourism and providing a platform for people to connect with their roots."),
                  _photos(
                      photo: MyImgs.onboarding3,
                      photo2: MyImgs.onboarding3Reverse,
                      headline: "Let’s get you started",
                      subtitle:
                          'Let\'s Get Started! Now that you\'ve learned a little more about us, let\'s get started on your journey through cultural compass.'),
                ],
              ),
            ),
            // _currentPage == _numPages - 1
            //     ? Positioned(
            //         bottom: 40,
            //         right: 60.w,
            //         left: 60.w,
            //         child: Center(
            //           child: Container(
            //             height: Dimens.size48.h,
            //             width: 280.w,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.all(Radius.circular(20)),
            //                 border: Border.all(
            //                     color: MyColors.bodyBackground, width: 1)),
            //             child: GestureDetector(
            //               onTap: () {
            //                 Get.to(() => Login());
            //               },
            //               child: Center(
            //                 child: Text(
            //                   "Start FarmSharing".tr,
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .headline2!
            //                       .copyWith(
            //                         color: MyColors.textColor2,
            //                         //fontFamily: "TiemposHeadline-Regular",
            //                       ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //     : SizedBox(),
            _currentPage == 0
                ? SizedBox()
                : Positioned(
                    bottom: 60.h,
                    left: 18.w,
                    child: GestureDetector(
                      onTap: () {
                        if (_currentPage == 0) {
                        } else {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            MyImgs.expandRightDoubleClick,
                            scale: 3.5,
                          ),
                          Text("Previous",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 18.sp,
                                      color: MyColors.textColor)),
                        ],
                      ),
                    ),
                  ),
            Positioned(
              bottom: 60.h,
              right: 18.w,
              child: GestureDetector(
                onTap: () {
                  if (_currentPage == 2) {
                    Get.offAll(Login());
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Next",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18.sp, color: MyColors.textColor)),
                    Image.asset(
                      MyImgs.expandRightDouble,
                      scale: 3.5,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: _currentPage == _numPages - 1
      //     ? SizedBox()
      //     : FloatingActionButton(
      //         backgroundColor: MyColors.bodyBackground.withOpacity(.6),
      //         child: Icon(
      //           Icons.arrow_forward,
      //           color: Colors.white,
      //         ),
      //         onPressed: () {
      //           _pageController.nextPage(
      //             duration: const Duration(milliseconds: 500),
      //             curve: Curves.ease,
      //           );
      //         },
      //       ),
    );
  }

  Widget _photos(
      {required String photo,
      required String photo2,
      required String headline,
      required String subtitle}) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 100.h,
        ),
        Padding(
          padding: EdgeInsets.only(right: 18.w),
          child: GestureDetector(
            onTap: () {
              Get.offAll(Login());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Skip",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 18.sp, color: MyColors.textColor)),
                Image.asset(
                  MyImgs.expandRightDouble,
                  scale: 3.5,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 9.h,
        ),
        Image.asset(photo),
        Image.asset(photo2),
        SizedBox(
          height: 95.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.size33.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headline.tr,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: MyColors.textColor, fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 50.h,
              ),
              Text(
                subtitle.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w400, color: MyColors.textColor),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
