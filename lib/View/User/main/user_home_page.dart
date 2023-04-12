import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => UserMainCubit()
          ..fetchEmployeeDetails()
          ..getUserInformation(),
        child: BlocConsumer<UserMainCubit, UserMainStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = UserMainCubit.get(context);
              var theme = Theme.of(context).textTheme;
              return marginContainer(
                  child: ConditionalBuilder(
                condition: state is GetUserInformationLoadingState,
                builder: (BuildContext context) =>
                    Center(child: circularProgressIndicator()),
                fallback: (BuildContext context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    child: Column(children: [
                      Padding(
                          padding:
                              const EdgeInsets.only(bottom: 12.0, top: 8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    radius: 40,
                                    child: ClipOval(
                                        child: Image.asset(
                                            ImageAsset.defaultAvatar))),
                                const SizedBox(width: 30.0),
                                Text(
                                    '${greeting()}\n${cubit.userModel.data!.fullName}',
                                    style:
                                        Theme.of(context).textTheme.titleLarge!,
                                    textAlign: TextAlign.left)
                              ])),
                      Container(
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(30)),
                          width: double.infinity,
                          child: Column(
                            children: [
                              const SizedBox(height: 6),
                              digitalClock(),
                              Text(
                                  DateFormat('yyyy/MM/dd')
                                      .format(DateTime.now()),
                                  style: const TextStyle(fontSize: 18)),
                              heightSizedBox(),
                              primaryButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoute.attendance);
                                    Future.delayed(
                                      const Duration(seconds: 2),
                                    );
                                  },
                                  width: 300,
                                  primaryColor: AppColor.dashboardColor6,
                                  text: 'Go to mark attendance'),
                              heightSizedBox(),
                            ],
                          )),
                      heightSizedBox(),
                      attendanceContainerBuilder(context, cubit),
                      heightSizedBox(),
                      salaryContainerBuild(context, cubit)
                    ]),
                  ),
                ),
              ));
            }));
  }

  Widget attendanceContainerBuilder(context, cubit) => Container(
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
              child: Row(children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Attendance',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Text(
                  DateFormat('yyyy/MM/dd').format(DateTime.now()),
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ]),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              height: 100,
              child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.3,
                  crossAxisCount: 3,
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      surfaceTintColor: AppColor.blackColor,
                      color: AppColor.dashboardColor6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${cubit.employeeDetails['data']['dayOnTime']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: AppColor.whiteColor),
                            ),
                            Text(
                              userHomePageCard[0].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColor.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      surfaceTintColor: AppColor.blackColor,
                      color: AppColor.dashboardColor4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${cubit.employeeDetails['data']['dayOff']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: AppColor.whiteColor),
                            ),
                            Text(
                              userHomePageCard[1].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColor.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      surfaceTintColor: AppColor.blackColor,
                      color: AppColor.dashboardColor3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${cubit.employeeDetails['data']['dayLate']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: AppColor.whiteColor),
                            ),
                            Text(
                              userHomePageCard[2].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColor.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      );

  Widget salaryContainerBuild(context, cubit) => Container(
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
              child: Row(children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Salary',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Text(
                  DateFormat('yyyy/MM/dd').format(DateTime.now()),
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ]),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              //height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Basic Salary',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    Text('${cubit.employeeDetails['data']['salary']} SYP',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
