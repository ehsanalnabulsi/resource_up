import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resource_up/View/Admin/EmployeeManagment/employeesAttendance/cubit/states.dart';
import 'package:resource_up/View/Shared/Widgets/shimmer.dart';

import 'package:resource_up/data/datasource/static/static.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../Shared/Widgets/container.dart';
import 'cubit/cubit.dart';

class EmployeesAttendance extends StatelessWidget {
  const EmployeesAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            EmployeesAttendanceCubit()..getEmployeesAttendance(),
        child:
            BlocConsumer<EmployeesAttendanceCubit, EmployeesAttendanceStates>(
                listener: (BuildContext context, Object? state) {},
                builder: (BuildContext context, state) {
                  var cubit = EmployeesAttendanceCubit.get(context);
                  return Scaffold(
                    appBar: AppBar(
                      flexibleSpace: Container(
                        decoration:
                            const BoxDecoration(color: AppColor.primaryColor),
                      ),
                      title: const Text(
                        'Employees Atendance',
                        style: TextStyle(
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                    body: radiusContainer(
                        child: marginContainer(
                            child: ConditionalBuilder(
                      condition: state is GetEmployeesAttendanceLoadingState,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: shimmerBuilder(context),
                      ),
                      fallback: (context) => attendListBuilder(cubit),
                    ))),
                  );
                }));
  }
}

Widget attendListBuilder(cubit) => ListView.separated(
    itemBuilder: ((context, index) => SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColor.whiteColor),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: ClipOval(
                                        child: Image.asset(
                                            ImageAsset.defaultAvatar))),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                margin: const EdgeInsets.all(12.0),
                                child: Text(
                                  cubit.attendanceList['data'][index]
                                      ['fullName'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(color: AppColor.blackColor),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: cubit.attendanceList['data']
                                                        [index]
                                                    ['attendanceStatus'] ==
                                                'present'
                                            ? AppColor.dashboardColor6
                                                .withOpacity(0.90)
                                            : cubit.attendanceList['data']
                                                            [index]
                                                        ['attendanceStatus'] ==
                                                    'late'
                                                ? AppColor.dashboardColor3
                                                    .withOpacity(0.90)
                                                : AppColor.dashboardColor4),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        cubit.attendanceList['data'][index]
                                            ['attendanceStatus'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: AppColor.whiteColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text('Date',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!),
                              ),
                              Expanded(
                                child: Text('In Time',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!),
                              ),
                              Expanded(
                                child: Text('Out Time',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!),
                              ),
                            ],
                          ),
                          Divider(
                              thickness: 1,
                              color: AppColor.greyColor2.withOpacity(.5)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                    cubit.attendanceList['data'][index]['date'],
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!),
                              ),
                              Expanded(
                                child: Text(
                                    '${cubit.attendanceList['data'][index]['checkIn_hour']} : ${cubit.attendanceList['data'][index]['checkIn_minute']}',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!),
                              ),
                              Expanded(
                                child: Text(
                                    '${cubit.attendanceList['data'][index]['checkOut_hour']} : ${cubit.attendanceList['data'][index]['checkOut_minute']}',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!),
                              ),
                            ],
                          ),
                        ]),
                      )
                    ],
                  )),
            ],
          ),
        )),
    separatorBuilder: ((context, index) => const Divider(
          thickness: 1,
          color: AppColor.greyColor1,
        )),
    itemCount: 2);
