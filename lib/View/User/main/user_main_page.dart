import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resource_up/View/Shared/Widgets/container.dart';
import 'package:resource_up/View/User/main/cubit/cubit.dart';
import 'package:resource_up/View/User/main/cubit/states.dart';

import '../../../core/constant/app_color.dart';

class UserMainPage extends StatelessWidget {
  const UserMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

    return BlocProvider(
      create: (BuildContext context) => UserMainCubit(),
      child: BlocConsumer<UserMainCubit, UserMainStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = UserMainCubit.get(context);
            // var theme = Theme.of(context).appBarTheme;
            return Scaffold(
                bottomNavigationBar: Container(
                  decoration: const BoxDecoration(color: AppColor.primaryColor),
                  child: CurvedNavigationBar(
                    key: bottomNavigationKey,
                    index: cubit.currentIndex,
                    height: 60.0,
                    items: const <Widget>[
                      Icon(Icons.home_outlined,
                          size: 30, color: AppColor.whiteColor),
                      Icon(Icons.document_scanner_outlined,
                          size: 30, color: AppColor.whiteColor),
                      // Icon(Icons.inbox_outlined,
                      //     size: 30, color: AppColor.whiteColor),
                      Icon(Icons.perm_identity,
                          size: 30, color: AppColor.whiteColor),
                    ],
                    color: AppColor.primaryColor,
                    buttonBackgroundColor: AppColor.primaryColor,
                    backgroundColor: AppColor.greyColor1,
                    animationCurve: Curves.easeInOut,
                    animationDuration: const Duration(milliseconds: 400),
                    onTap: (index) {
                      cubit.changeIndex(index);
                    },
                    letIndexChange: (index) => true,
                  ),
                ),
                appBar: AppBar(
                  flexibleSpace: Container(
                    decoration:
                        const BoxDecoration(color: AppColor.primaryColor),
                  ),
                  title: Text(cubit.titles[cubit.currentIndex],
                      style: Theme.of(context).appBarTheme.titleTextStyle),
                ),
                body: radiusContainer(
                  child: marginContainer(
                      child: cubit.bottomPages[cubit.currentIndex]),
                ));
          }),
    );
  }
}
