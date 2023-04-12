import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:resource_up/View/Admin/EmployeeManagment/employeesList/cubit/cubit.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/functions/validator.dart';
import '../../../Shared/Widgets/buttons.dart';
import '../../../Shared/Widgets/circular_progress_indicator.dart';
import '../../../Shared/Widgets/container.dart';
import '../../../Shared/Widgets/form_fields.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AddEmployee extends StatelessWidget {
  const AddEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var fullNameController = TextEditingController();
    var phoneNumberController = TextEditingController();
    var birthdateController = TextEditingController();
    final genderController = TextEditingController(text: 'Male');
    var departmentController = TextEditingController();
    var positionController = TextEditingController();
    var salaryController = TextEditingController();
    List workingDays = [];

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AddEmployeeCubit()
            ..getPositions()
            ..getDepartments(),
        ),
        BlocProvider(create: (BuildContext context) => EmployeesCubit())
      ],
      child: BlocConsumer<AddEmployeeCubit, AddEmployeeStates>(
        listener: (BuildContext context, state) {
          if (state is AddEmployeeSuccessState) {
            if (state.addEmployeeModel.status!) {
              final snackBar = SnackBar(
                duration: const Duration(milliseconds: 3000),
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                    title: '${state.addEmployeeModel.status}',
                    message: '${state.addEmployeeModel.message}',
                    contentType: ContentType.success),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            } else {
              final snackBar = SnackBar(
                  duration: const Duration(milliseconds: 1000),
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                      title: '${state.addEmployeeModel.status}',
                      message: '${state.addEmployeeModel.message}',
                      contentType: ContentType.warning));
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          }
          // else {
          //   final snackBar = SnackBar(
          //     duration: const Duration(milliseconds: 1000),
          //     elevation: 0,
          //     behavior: SnackBarBehavior.floating,
          //     backgroundColor: Colors.transparent,
          //     content: AwesomeSnackbarContent(
          //       title: 'Error !',
          //       message: 'Connection Timed Out',
          //       contentType: ContentType.failure,
          //     ),
          //   );
          //   ScaffoldMessenger.of(context)
          //     ..hideCurrentSnackBar()
          //     ..showSnackBar(snackBar);
          // }
        },
        builder: (BuildContext context, state) {
          var cubit = AddEmployeeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(color: AppColor.primaryColor),
              ),
              title: const Text(
                'Add New Employee',
                style: TextStyle(
                  color: AppColor.whiteColor,
                ),
              ),
            ),
            body: radiusContainer(
                child: marginContainer(
              horizontalMargin: 16.0,
              verticalMargin: 16.0,
              child: ConditionalBuilder(
                condition: state is GetDepartmentsListLoadingState &&
                    state is GetPositionsListLoadingState,
                builder: (context) => circularProgressIndicator(),
                fallback: (context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(children: [
                                  CircleAvatar(
                                      backgroundColor: AppColor.primaryColor,
                                      radius: 50,
                                      backgroundImage: cubit.imageFile != null
                                          ? Image.file(cubit.imageFile!).image
                                          : Image.asset(
                                                  ImageAsset.defaultAvatar)
                                              .image,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                      )),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 35.0,
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: GestureDetector(
                                            onTap: () => cubit.pickImage(),
                                            child: const Icon(Icons.add_a_photo,
                                                color: AppColor.whiteColor,
                                                size: 16.0)),
                                      ))
                                ]),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [
                                      textFormField(
                                        hintText: 'Wessam A Baker',
                                        labelText: 'Employee Name',
                                        controller: fullNameController,
                                        keyboardType: TextInputType.text,
                                        prefixIcon:
                                            Icons.perm_identity_outlined,
                                        validator: (value) => validInput(
                                            value!, 5, 25, 'fullname'),
                                      ),
                                      const SizedBox(height: 6.0),
                                      textFormField(
                                          hintText: '+123 456 7890',
                                          labelText: 'Phone Number',
                                          keyboardType: TextInputType.phone,
                                          prefixIcon: Icons.phone_outlined,
                                          validator: (value) => validInput(
                                              value!, 5, 12, 'phonenumber'),
                                          controller: phoneNumberController),
                                    ])))
                          ]),
                          const Divider(thickness: 1, height: 20.0),
                          Text('Gender & Birth Date',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColor.primaryColor)),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: CupertinoRadioChoice(
                                      notSelectedColor: AppColor.greyColor3,
                                      selectedColor: AppColor.primaryColor,
                                      choices: const {
                                        'Male': 'Male',
                                        'Female': 'Female',
                                      },
                                      onChange: (selectedGender) =>
                                          genderController.text =
                                              selectedGender,
                                      initialKeyValue: 'Male')),
                              const SizedBox(width: 4.0),
                              Expanded(
                                flex: 3,
                                child: textFormField(
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    return null;
                                  },
                                  prefixIcon: Icons.date_range_outlined,
                                  controller: birthdateController,
                                  hintText: DateTime.now().toString(),
                                  labelText: 'Birth Date',
                                  onTap: () {
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) => SizedBox(
                                              height: 200,
                                              child: CupertinoDatePicker(
                                                backgroundColor:
                                                    AppColor.whiteColor,
                                                initialDateTime: DateTime.now(),
                                                mode: CupertinoDatePickerMode
                                                    .date,
                                                maximumDate: DateTime.now(),
                                                onDateTimeChanged:
                                                    (DateTime value) {
                                                  birthdateController.text =
                                                      DateFormat("yyyy-MM-dd")
                                                          .format(value);
                                                },
                                              ),
                                            ));
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Divider(thickness: 1, height: 20.0),
                          Text('Employee Department & Position',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColor.primaryColor)),
                          const SizedBox(height: 8.0),
                          Row(children: [
                            Expanded(
                              child: dropDownButton(
                                  dropDownList: cubit.departmentsNameList,
                                  onChange: (value) {
                                    departmentController.text = value;
                                  },
                                  selectedItem: 'Department'),
                            ),
                            Expanded(
                              child: dropDownButton(
                                  dropDownList: cubit.positionsNameList,
                                  onChange: (value) {
                                    positionController.text = value;
                                  },
                                  selectedItem: 'Position'),
                            ),
                          ]),
                          const Divider(thickness: 1, height: 20.0),
                          multiSelect(
                              title: 'Working Days',
                              items: cubit.workingDays,
                              onSelectionDone: (List value) {
                                workingDays = value;
                                print(workingDays);
                                print(value);
                              }),
                          const SizedBox(height: 16.0),
                          textFormField(
                            labelText: 'Basic Salary',
                            prefixIcon: Icons.attach_money_rounded,
                            hintText: '300,000 SYP',
                            controller: salaryController,
                            validator: (value) {
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16.0),
                          ConditionalBuilder(
                            condition: state is AddEmployeeLoadingState,
                            builder: (context) => circularProgressIndicator(),
                            fallback: (context) => primaryButton(
                                text: 'Add Employee',
                                width: MediaQuery.of(context).size.width,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.addEmployee(
                                        fullName: fullNameController.text,
                                        phoneNumber: phoneNumberController.text,
                                        birthDate: birthdateController.text,
                                        department: departmentController.text,
                                        position: positionController.text,
                                        wokringDays: workingDays,
                                        gender: genderController.text,
                                        imageFile: cubit.imageFile,
                                        workingDays: workingDays,
                                        salary:
                                           salaryController.text);
                                  }
                                }),
                          ),
                        ]),
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
