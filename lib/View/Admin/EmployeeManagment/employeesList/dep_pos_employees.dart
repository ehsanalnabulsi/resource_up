import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:resource_up/View/Admin/Main/cubit/cubit.dart';
import 'package:resource_up/View/Admin/Main/cubit/states.dart';
import 'package:resource_up/core/constant/image_asset.dart';

import 'package:resource_up/core/constant/routes.dart';

import '../../../../core/constant/app_color.dart';
import '../../../Shared/Widgets/container.dart';
import '../../../Shared/Widgets/shimmer.dart';

class DepartmentEmployees extends StatelessWidget {
  const DepartmentEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    List departmentEmployeesList;
    departmentEmployeesList =
        ModalRoute.of(context)?.settings.arguments as List;
    return BlocProvider(
        create: (context) => AdminMainCubit(),
        child: BlocConsumer<AdminMainCubit, AdminMainStates>(
            listener: (BuildContext context, Object? state) {},
            builder: (BuildContext context, state) {
              var cubit = AdminMainCubit.get(context);

              // var search = cubit.search;
              return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: AppColor.primaryColor,
                    onPressed: () {
                      Get.toNamed(AppRoute.addEmployee);
                    },
                    child: const Icon(Icons.add),
                  ),
                  appBar: AppBar(
                    flexibleSpace: Container(
                      decoration:
                          const BoxDecoration(color: AppColor.primaryColor),
                    ),
                    title: const Text(
                      'Department Employees',
                      style: TextStyle(
                        // fontFamily: 'PlayfairDisplay',
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                  body: radiusContainer(
                      child: marginContainer(
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ConditionalBuilder(
                          condition:
                              state is GetDepartmentEmployeesListLoadingState,
                          builder: (BuildContext context) =>
                              shimmerBuilder(context),
                          fallback: (BuildContext context) =>
                              ConditionalBuilder(
                            condition: state
                                    is GetDepartmentEmployeesListSuccessState &&
                                cubit.departmentEmployeesList.isEmpty,
                            builder: (context) => SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: const Center(child: Text('no employee')),
                            ),
                            fallback: (context) => ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (
                                  BuildContext context,
                                  int index,
                                ) {
                                  return Slidable(
                                    startActionPane: ActionPane(
                                      extentRatio: 0.3333,
                                      dragDismissible: false,
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (BuildContext context) {},
                                          backgroundColor:
                                              AppColor.dashboardColor4,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    key: ValueKey(index),
                                    child: ListTile(
                                      onTap: () {
                                        cubit.fetchEmployeeDetails(
                                            cubit.departmentEmployeesList[index]
                                                ['user_id']);
                                      },
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 30.0,
                                        child: ClipOval(
                                          child: Image.asset(
                                            ImageAsset.defaultAvatar,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        departmentEmployeesList[index]
                                                ['fullName']
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                color: AppColor.blackColor),
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: AppColor.primaryColor,
                                        size: 24.0,
                                      ),
                                      subtitle: Text(
                                        departmentEmployeesList[index]
                                            ['positionsName'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(
                                          thickness: 1,
                                          color: AppColor.greyColor1,
                                        ),
                                itemCount: departmentEmployeesList.length),
                          ),
                        )),
                  )));
            }));
  }
}
