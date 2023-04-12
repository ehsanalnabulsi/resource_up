import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../data/datasource/static/static.dart';
import '../../../Shared/Widgets/container.dart';
import '../../Main/cubit/cubit.dart';
import '../../Main/cubit/states.dart';

class EmployeeDepartmentPage extends StatelessWidget {
  const EmployeeDepartmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> employeeDetails;
    employeeDetails =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider(
        create: (context) => AdminMainCubit(),
        child: BlocConsumer<AdminMainCubit, AdminMainStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AdminMainCubit.get(context);

              return Scaffold(
                appBar: AppBar(backgroundColor: AppColor.primaryColor),
                body: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration:
                            const BoxDecoration(color: AppColor.primaryColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 40,
                              child: ClipOval(
                                  child: Image.asset(ImageAsset.defaultAvatar)),
                            ),
                            Container(
                              margin: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${employeeDetails['data']['fullName']}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(color: AppColor.whiteColor),
                                  ),
                                  Text(
                                    '${employeeDetails['data']['positionsName']}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: AppColor.whiteColor,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColor.greyColor1.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(25)),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      radiusContainer(
                          child: marginContainer(
                              child: Column(
                        children: [
                          employeeDetailsBuilder(context, employeeDetails),
                          heightSizedBox(),
                          attendanceContainerBuilder(context, employeeDetails),
                          heightSizedBox(),
                          salaryContainerBuild(context, employeeDetails)
                        ],
                      ))),
                    ],
                  ),
                ),
              );
            }));
  }

  Widget employeeDetailsBuilder(context, employeeDetails) => Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(25),
        ),
        height: 150,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Department  ',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppColor.primaryColor)),
                    Text(
                      employeeDetails['data']['departmentName'],
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColor.greyColor3),
                    )
                  ],
                ),
                SizedBox(
                  width: 50.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gender',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppColor.primaryColor)),
                    Text(
                      employeeDetails['data']['gender'].toString(),
                      //'Male',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColor.greyColor3),
                    )
                  ],
                ),
              ]),
              SizedBox(height: 16.0),
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mobile Phone',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppColor.primaryColor)),
                    Text(
                      employeeDetails['data']['phoneNumber'].toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColor.greyColor3),
                    )
                  ],
                ),
                SizedBox(
                  width: 50.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppColor.primaryColor)),
                    Text(
                      employeeDetails['data']['address'].toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColor.greyColor3),
                    )
                  ],
                ),
              ]),
            ]),
      );
  Widget attendanceContainerBuilder(context, employeeDetails) => Container(
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
                  childAspectRatio: 1.5,
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
                              '${employeeDetails['data']['dayOnTime']}',
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
                              '${employeeDetails['data']['dayOff']}',
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
                              '${employeeDetails['data']['dayLate']}',
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

  Widget salaryContainerBuild(context, employeeDetails) => Container(
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
              // height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // crossAxisAlignment:
                  //     CrossAxisAlignment.center,
                  // mainAxisAlignment:
                  //     MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text('Basic Salary',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    Text('${employeeDetails['data']['salary']} \$',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
