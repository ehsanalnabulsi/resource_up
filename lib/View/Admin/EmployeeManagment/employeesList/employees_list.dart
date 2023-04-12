import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:resource_up/core/constant/image_asset.dart';

import 'package:resource_up/core/constant/routes.dart';

import '../../../../core/constant/app_color.dart';
import '../../../Shared/Widgets/container.dart';
import '../../../Shared/Widgets/shimmer.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Employees extends StatelessWidget {
  const Employees({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return BlocProvider(
        create: (context) => EmployeesCubit()..getEmployeeList(),
        child: BlocConsumer<EmployeesCubit, EmployeesStates>(
            listener: (BuildContext context, Object? state) {},
            builder: (BuildContext context, state) {
              var cubit = EmployeesCubit.get(context);

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
                      'Employees',
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
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 12.0, vertical: 22),
                              //   child: textFormField(
                              //     keyboardType: TextInputType.text,
                              //     validator: (value) {
                              //       return null;
                              //     },
                              //     onChanged: (value) {
                              //       //cubit.getSearch(value);
                              //       //  var list = cubit.search;
                              //     },
                              //     prefixIcon: Icons.search,
                              //     controller: searchController,
                              //     hintText: 'Search for Employee',
                              //     hintTextSize: 18.0,
                              //   ),
                              // ),
                              Padding(padding: EdgeInsets.all(12)),
                              ConditionalBuilder(
                                condition:
                                    state is GetEmployeesListLoadingState,
                                builder: (BuildContext context) =>
                                    shimmerBuilder(context),
                                fallback: (BuildContext context) =>
                                    ConditionalBuilder(
                                  condition:
                                      state is GetEmployeesListSuccessState &&
                                          cubit.employeeList.isEmpty,
                                  builder: (context) => SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: const Center(
                                        child: Text('no employee')),
                                  ),
                                  fallback: (context) => ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                                                onPressed:
                                                    (BuildContext context) {
                                                  cubit.removeEmployee(
                                                      cubit.employeeList[index]
                                                          ['user_id_id']);
                                                },
                                                backgroundColor:
                                                    AppColor.dashboardColor4,
                                                foregroundColor: Colors.white,
                                                icon: Icons.delete,
                                                label: 'Delete',
                                              ),
                                            ],
                                          ),
                                          key: ValueKey(
                                              cubit.employeeList[index]['id']),
                                          child: ListTile(
                                            onTap: () {
                                              cubit.fetchEmployeeDetails(
                                                  cubit.employeeList[index]
                                                      ['user_id_id']);
                                            },
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 30.0,
                                              child: ClipOval(
                                                child: Image.asset(
                                                  ImageAsset.defaultAvatar,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              '${cubit.employeeList[index]['fullName']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      color:
                                                          AppColor.blackColor),
                                            ),
                                            trailing: const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: AppColor.primaryColor,
                                              size: 24.0,
                                            ),
                                            subtitle: Text(
                                              '${cubit.employeeList[index]['positionsName']}',
                                              // 'text',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.normal),
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
                                      itemCount: cubit.employeeList.length),
                                ),
                              )
                            ])),
                  )));
            }));
  }
}
