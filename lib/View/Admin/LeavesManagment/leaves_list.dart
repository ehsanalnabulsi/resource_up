import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:resource_up/View/Shared/Widgets/buttons.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../data/model/leaves_model.dart';
import '../../Shared/Widgets/container.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LeavesList extends StatelessWidget {
  const LeavesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LeavesCubit()..filterLeaves(),
        child: BlocConsumer<LeavesCubit, LeavesStates>(
            listener: (BuildContext context, Object? state) {},
            builder: (BuildContext context, state) {
              var cubit = LeavesCubit.get(context);
              List<Leave> pendingLeavesList = cubit.pendingLeavesList;
              List<Leave> approvedLeavesList = cubit.approvedLeavesList;
              List<Leave> rejectedLeavesList = cubit.rejectedLeavesList;
              //var search = cubit.search;
              return DefaultTabController(
                length: 3,
                child: Scaffold(
                    appBar: AppBar(
                      bottom: TabBar(
                          automaticIndicatorColorAdjustment: true,
                          isScrollable: true,
                          physics: const NeverScrollableScrollPhysics(),
                          indicatorColor: AppColor.dashboardColor1,
                          tabs: cubit.tabs),
                      flexibleSpace: Container(
                        decoration:
                            const BoxDecoration(color: AppColor.primaryColor),
                      ),
                      title: const Text(
                        'Leave Requests List',
                        style: TextStyle(
                          // fontFamily: 'PlayfairDisplay',
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                    body: radiusContainer(
                        child: marginContainer(
                            child: TabBarView(
                      // physics: const NeverScrollableScrollPhysics(),
                      children: [
                        pendingLeavesTabBuilder(cubit, pendingLeavesList),
                        approvedLeavesTabBuilder(approvedLeavesList),
                        rejectedLeavesTabBuilder(rejectedLeavesList),
                      ],
                    )))),
              );
            }));
  }

  Widget pendingLeavesTabBuilder(cubit, leaves) => ListView.separated(
      itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(50)),
            child: Column(children: [
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
                                            ImageAsset.companyLogo))),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                margin: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      leaves[index].employee.fullName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(color: AppColor.blackColor),
                                    ),
                                    Text(
                                      '${leaves[index].employee.position}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: AppColor.greyColor3,
                                              fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: leaves[index].type ==
                                                LeaveType.annual.name
                                            ? AppColor.dashboardColor3
                                                .withOpacity(0.90)
                                            : leaves[index].type ==
                                                    LeaveType.sick.name
                                                ? AppColor.dashboardColor4
                                                    .withOpacity(0.90)
                                                : AppColor.dashboardColor6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        '${leaves[index].type}',
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
                        padding: const EdgeInsets.all(6.0),
                        child: Column(children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text('From Date',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!),
                              ),
                              Expanded(
                                child: Text('To Date',
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
                                    Jiffy(leaves[index].startDate).yMMMdjm,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!),
                              ),
                              Expanded(
                                child: Text(
                                    Jiffy(leaves[index].endDate).yMMMdjm,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Text('Notes : ${leaves[index].notes}',
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              const SizedBox(width: 30.0),
                              Expanded(
                                child: primaryButton(
                                    onPressed: () {
                                      cubit.approveLeave(leaves[index].id);
                                    },
                                    text: 'Approve',
                                    primaryColor: AppColor.primaryColor),
                              ),
                              const SizedBox(width: 30.0),
                              Expanded(
                                child: secondaryButton(
                                    onPressed: () {
                                      cubit.rejectLeave(leaves[index].id);
                                    },
                                    text: 'Reject',
                                    primaryColor: AppColor.dashboardColor3),
                              ),
                              const SizedBox(width: 30.0),
                            ],
                          )
                        ]),
                      )
                    ],
                  )),
            ]),
          ),
      separatorBuilder: (context, index) => const Divider(
            color: AppColor.greyColor1,
            thickness: 1,
          ),
      itemCount: leaves.length);
  Widget approvedLeavesTabBuilder(leaves) => ListView.separated(
      itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(50)),
            child: Column(children: [
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
                                                ImageAsset.companyLogo))))),
                            Expanded(
                              flex: 6,
                              child: Container(
                                margin: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      leaves[index].employee.fullName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(color: AppColor.blackColor),
                                    ),
                                    Text(
                                      '${leaves[index].employee.position}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: AppColor.greyColor3,
                                              fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: leaves[index].type ==
                                                LeaveType.annual.name
                                            ? AppColor.dashboardColor3
                                                .withOpacity(0.90)
                                            : leaves[index].type ==
                                                    LeaveType.sick.name
                                                ? AppColor.dashboardColor4
                                                    .withOpacity(0.90)
                                                : AppColor.dashboardColor6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        '${leaves[index].type}',
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
                        padding: const EdgeInsets.all(6.0),
                        child: Column(children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text('From Date',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!),
                              ),
                              Expanded(
                                child: Text('To Date',
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
                                    Jiffy(leaves[index].startDate).yMMMdjm,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!),
                              ),
                              Expanded(
                                child: Text(
                                    Jiffy(leaves[index].endDate).yMMMdjm,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Text('Notes : ${leaves[index].notes}',
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 16.0),
                          Text('Request Leave Is Approved',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColor.dashboardColor6)),
                        ]),
                      )
                    ],
                  )),
            ]),
          ),
      separatorBuilder: (context, index) => const Divider(
            color: AppColor.greyColor1,
            thickness: 1,
          ),
      itemCount: leaves.length);
  Widget rejectedLeavesTabBuilder(leaves) => ListView.separated(
      itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(50)),
            child: Column(children: [
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
                                            ImageAsset.companyLogo))),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                margin: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      leaves[index].employee.fullName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(color: AppColor.blackColor),
                                    ),
                                    Text(
                                      '${leaves[index].employee.position}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: AppColor.greyColor3,
                                              fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: leaves[index].type ==
                                                LeaveType.annual.name
                                            ? AppColor.dashboardColor3
                                                .withOpacity(0.90)
                                            : leaves[index].type ==
                                                    LeaveType.sick.name
                                                ? AppColor.dashboardColor4
                                                    .withOpacity(0.90)
                                                : AppColor.dashboardColor6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        '${leaves[index].type}',
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
                        padding: const EdgeInsets.all(6.0),
                        child: Column(children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text('From Date',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!),
                              ),
                              Expanded(
                                child: Text('To Date',
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
                                    Jiffy(leaves[index].startDate).yMMMdjm,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!),
                              ),
                              Expanded(
                                child: Text(
                                    Jiffy(leaves[index].endDate).yMMMdjm,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Text('Notes : ${leaves[index].notes}',
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 16.0),
                          Text('Request Leave Is Rejected',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColor.dashboardColor4)),
                        ]),
                      )
                    ],
                  )),
            ]),
          ),
      separatorBuilder: (context, index) => const Divider(
            color: AppColor.greyColor1,
            thickness: 1,
          ),
      itemCount: leaves.length);
}
