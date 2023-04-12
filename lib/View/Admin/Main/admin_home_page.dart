import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:resource_up/View/Shared/Widgets/shimmer.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/routes.dart';
import '../../../core/functions/greeting.dart';
import '../../../data/datasource/static/static.dart';
import '../../Shared/Widgets/buttons.dart';
import '../../Shared/Widgets/circular_progress_indicator.dart';
import '../../Shared/Widgets/container.dart';
import '../../Shared/Widgets/digital_clock.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            AdminMainCubit()..getUserInformation(),
        child: BlocConsumer<AdminMainCubit, AdminMainStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AdminMainCubit.get(context);
              // var theme = Theme.of(context).appBarTheme;
              return marginContainer(
                  child: ConditionalBuilder(
                condition: state is GetUserInformationLoadingState,
                builder: (BuildContext context) =>
                    Center(child: shimmerBuilder(context)),
                fallback: (BuildContext context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  //   backgroundColor: Colors.amber,
                                  radius: 40,
                                  child: ClipOval(
                                      child: Image.asset(
                                          ImageAsset.defaultAvatar))),
                              const SizedBox(width: 30.0),
                              Text(
                                  '${greeting()}\n${cubit.userModel.data!.fullName}',
                                  // 'hello',
                                  style:
                                      Theme.of(context).textTheme.titleLarge!,
                                  textAlign: TextAlign.left)
                            ])),
                    Container(
                        decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(30)),
                        width: double.infinity,
                        // height: 250.0,
                        child: Column(
                          children: [
                            const SizedBox(height: 6),
                            digitalClock(),
                            Text(Jiffy(DateTime.now()).yMMMMEEEEd,
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 12.0),
                            primaryButton(
                                onPressed: () =>
                                    Get.toNamed(AppRoute.attendance),
                                width: 300,
                                primaryColor: AppColor.dashboardColor6,
                                text: 'Go to mark attendance'),
                            const SizedBox(height: 12.0),
                          ],
                        )),
                    const SizedBox(height: 16.0),
                    employeesTileBuilder(context),
                    payrollsTileBuilder(context),
                    requeststTileBuilder(context),
                    filesTileBuilder(context),
                    recruitmentTileBuilder(context),
                  ]),
                ),
              ));
            }));
  }

  Widget employeesTileBuilder(context) => ExpansionTile(
      backgroundColor: AppColor.whiteColor,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      iconColor: AppColor.whiteColor,
      textColor: AppColor.blackColor,
      collapsedTextColor: AppColor.blackColor,
      collapsedIconColor: AppColor.whiteColor,
      leading: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
            color: AppColor.dashboardColor3,
            borderRadius: BorderRadius.circular(15)),
        child: const Icon(
          Icons.groups_outlined,
          size: 35.0,
        ),
      ),
      trailing: const SizedBox.shrink(),
      title: Text(
        'Employee Managment',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: const Text('Manage your employees'),
      children: employeeManagmentTiles);
  Widget payrollsTileBuilder(context) => ExpansionTile(
      backgroundColor: AppColor.whiteColor,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      iconColor: AppColor.whiteColor,
      textColor: AppColor.blackColor,
      collapsedTextColor: AppColor.blackColor,
      collapsedIconColor: AppColor.whiteColor,
      leading: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
            color: AppColor.dashboardColor5,
            borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.attach_money_outlined, size: 35.0),
      ),
      trailing: const SizedBox.shrink(),
      title: Text(
        'Payrolls Managment',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: const Text('Get a payrolls overview'),
      children: payrollsManagmentTiles);
  Widget filesTileBuilder(context) => ExpansionTile(
      backgroundColor: AppColor.whiteColor,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      iconColor: AppColor.whiteColor,
      textColor: AppColor.blackColor,
      collapsedTextColor: AppColor.blackColor,
      collapsedIconColor: AppColor.whiteColor,
      leading: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
            color: AppColor.dashboardColor4,
            borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.file_copy_outlined, size: 35.0),
      ),
      trailing: const SizedBox.shrink(),
      title: Text(
        'Files Managment',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: const Text('Manage your data & files'),
      children: filesManagmentTiles);
  Widget recruitmentTileBuilder(context) => ExpansionTile(
      backgroundColor: AppColor.whiteColor,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      iconColor: AppColor.whiteColor,
      textColor: AppColor.blackColor,
      collapsedTextColor: AppColor.blackColor,
      collapsedIconColor: AppColor.whiteColor,
      leading: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
            color: AppColor.dashboardColor7,
            borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.people_outline_rounded, size: 35.0),
      ),
      trailing: const SizedBox.shrink(),
      title: Text(
        'Recruit Managment',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: const Text('Manage your recruitment'),
      children: recruitmentManagmentTiles);

  Widget requeststTileBuilder(context) => ExpansionTile(
      backgroundColor: AppColor.whiteColor,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      iconColor: AppColor.whiteColor,
      textColor: AppColor.blackColor,
      // onTap: () {
      //   Get.toNamed(AppRoute.leavesList);
      // },
      collapsedTextColor: AppColor.blackColor,
      collapsedIconColor: AppColor.whiteColor,
      leading: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
            color: AppColor.dashboardColor6,
            borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.request_page_outlined, size: 35.0),
      ),
      trailing: const SizedBox.shrink(),
      title: Text(
        'Requests Managment',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: const Text('Manage your Requests'),
      children: requeststManagmentTiles);
}
