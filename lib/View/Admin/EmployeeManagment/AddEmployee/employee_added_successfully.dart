import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:resource_up/View/shared/Widgets/buttons.dart';
import 'package:resource_up/View/shared/Widgets/container.dart';
import 'package:resource_up/core/constant/routes.dart';
// import 'package:image_picker/image_picker.dart';

import '../../../../core/constant/app_color.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class EmployeeAddedSuccessfully extends StatelessWidget {
  const EmployeeAddedSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    Map addedEmployeeDetails;
    addedEmployeeDetails =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    return BlocProvider(
      create: (BuildContext context) => AddEmployeeCubit(),
      child: BlocConsumer<AddEmployeeCubit, AddEmployeeStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          var cubit = AddEmployeeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(color: AppColor.primaryColor),
              ),
              title: const Text(
                'Added Successfully',
                style: TextStyle(
                  color: AppColor.whiteColor,
                ),
              ),
            ),
            body: radiusContainer(
              child: Container(
                height: 400.0,
                margin: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColor.greyColor1),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Employee Login Details: ',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              'Username: ${addedEmployeeDetails['data']['username']} ',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Text(
                              'Password: ${addedEmployeeDetails['data']['password']}',
                              style: TextStyle(fontSize: 16.0),
                            )
                          ]),
                    ),
                    const SizedBox(height: 20.0),
                    primaryButton(
                        onPressed: () => Get.toNamed(AppRoute.adminMainPage),
                        text: 'Go to Home'),
                    secondaryButton(
                        onPressed: () => Get.toNamed(AppRoute.employees),
                        text: 'Go To Employee List')
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
