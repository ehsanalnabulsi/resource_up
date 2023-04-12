import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:resource_up/View/Shared/Widgets/buttons.dart';
import 'package:resource_up/View/Shared/Widgets/logo.dart';
import 'package:resource_up/core/functions/dialogs.dart';
import 'package:resource_up/core/constant/routes.dart';
import 'package:resource_up/data/datasource/static/static.dart';
import 'package:resource_up/core/services/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constant/app_color.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    var onboardingController = PageController();
    return Scaffold(
      body: WillPopScope(
        onWillPop: exitAppAlert,
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 60),
            SizedBox(height: 60, child: logoImage()),
            const SizedBox(height: 70),
            Expanded(flex: 3, child: onboardingBulider(onboardingController)),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: onboardingController,
                    count: onBoardingList.length,
                    effect:const  ExpandingDotsEffect(
                      dotHeight: 8.0,
                      dotWidth: 12,
                      activeDotColor: AppColor.primaryColor,
                      spacing: 6.0,
                      expansionFactor: 2,
                      dotColor: AppColor.greyColor2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  primaryButton(
                      onPressed: () {
                        submit();
                        Get.offNamed(AppRoute.login);
                      },
                      text: "Log In"),
                  const SizedBox(height: 3.0),
                  secondaryButton(
                      onPressed: () {
                        submit();
                        Get.offNamed(AppRoute.register);
                      },
                      text: "Register New Company")
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  void submit() {
    CacheHelper.setData(key: 'onBoarding', value: true);
  }

  PageView onboardingBulider(onboardingController) => PageView.builder(
      physics: const BouncingScrollPhysics(),
      controller: onboardingController,
      itemCount: onBoardingList.length,
      itemBuilder: (context, i) => Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(onBoardingList[i].title!,
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  onBoardingList[i].image!,
                  height: 200,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  onBoardingList[i].body!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ));
}
