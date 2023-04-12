// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/routes.dart';

import '../../Shared/Widgets/circular_progress_indicator.dart';
import '../../Shared/Widgets/container.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AdminCompanyPage extends StatelessWidget {
  const AdminCompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AdminMainCubit()
          ..getCompanyInformation()
          ..getDepartments()
          ..getPositions(),
        child: BlocConsumer<AdminMainCubit, AdminMainStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AdminMainCubit.get(context);
              var theme = Theme.of(context).textTheme;

              return ConditionalBuilder(
                condition: state is GetCompanyInformationLoadingState,
                builder: (BuildContext context) => circularProgressIndicator(),
                fallback: (context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 120.0,
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: const BoxDecoration(),
                        child: Image.asset(
                          ImageAsset.companyLogo,
                        ),
                      ),
                      Text(
                        '${cubit.companyModel.data!.companyName}',
                        style: theme.headlineSmall!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.place_outlined,
                            color: AppColor.greyColor3,
                          ),
                          Text(
                            '${cubit.companyModel.data!.address}',
                            style: theme.titleMedium
                                ?.copyWith(color: AppColor.greyColor3),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Basic Information",
                                style: theme.titleLarge,
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Working Hours:',
                                style: theme.titleMedium,
                              ),
                              Container(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: AppColor.greyColor1.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text('Starting Time',
                                                  style: theme.bodyLarge!
                                                      .copyWith(
                                                          color: AppColor
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text('Ending Time',
                                                  style: theme.bodyLarge!
                                                      .copyWith(
                                                          color: AppColor
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      heightSizedBox(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                  '${cubit.companyModel.data!.startTime}',
                                                  style: theme.bodyLarge),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                  '${cubit.companyModel.data!.endTime}',
                                                  style: theme.bodyLarge),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              ExpansionTile(
                                childrenPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                iconColor: AppColor.primaryColor,
                                textColor: AppColor.primaryColor,
                                collapsedTextColor: AppColor.primaryColor,
                                collapsedIconColor: AppColor.primaryColor,
                                leading: const Icon(
                                  Icons.branding_watermark_rounded,
                                  size: 30.0,
                                ),
                                title: const Text(
                                  'Departments',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                subtitle: Text(
                                    '${cubit.companyModel.data!.departmentCount}'),
                                children: cubit.departmentsList.isEmpty
                                    ? [
                                        Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Center(
                                              child: Text(
                                                  'There is no departments')),
                                        ),
                                        SizedBox(
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.add,
                                              color: AppColor.primaryColor,
                                            ),
                                          ),
                                        )
                                      ]
                                    : List.generate(
                                        cubit.departmentsList.length,
                                        (index) => ListTile(
                                            title: Text(
                                                '${cubit.departmentsList[index]['departmentName']}'),
                                            trailing: const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 16.0,
                                              color: AppColor.primaryColor,
                                            ),
                                            onTap: () {
                                              cubit.getDepartmentEmployeeList(
                                                  cubit.departmentsList[index]
                                                      ['id']);
                                            }),
                                      ),
                              ),
                              ExpansionTile(
                                childrenPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                iconColor: Color.fromARGB(255, 23, 45, 79),
                                textColor: AppColor.primaryColor,
                                collapsedTextColor: AppColor.primaryColor,
                                collapsedIconColor: AppColor.primaryColor,
                                leading: const Icon(
                                  Icons.branding_watermark_rounded,
                                  size: 30.0,
                                ),
                                title: const Text(
                                  'Positions',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                subtitle: Text(
                                    '${cubit.companyModel.data!.departmentCount}'),
                                children: cubit.positionsList.isEmpty
                                    ? [
                                        const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Center(
                                              child: Text(
                                                  'There is no positions')),
                                        )
                                      ]
                                    : List.generate(
                                        cubit.positionsList.length,
                                        (index) => ListTile(
                                            title: Text(
                                                '${cubit.positionsList[index]['positionName']}'),
                                            trailing: const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 16.0,
                                              color: AppColor.primaryColor,
                                            ),
                                            onTap: () {
                                              cubit.getPositionEmployeeList(
                                                  cubit.departmentsList[index]
                                                      ['id']);
                                            }),
                                      ),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.group_outlined,
                                  size: 40.0,
                                  color: AppColor.primaryColor,
                                ),
                                title: const Text(
                                  'Employees',
                                ),
                                subtitle: Text(
                                    '${cubit.companyModel.data!.employeeCount}'),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20.0,
                                ),
                                onTap: () => Get.toNamed(AppRoute.employees),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
