import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resource_up/View/Shared/Widgets/buttons.dart';
import 'package:resource_up/View/Shared/Widgets/circular_progress_indicator.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/functions/dialogs.dart';
import '../../../../core/functions/validator.dart';
import '../../../../core/services/local/cache_helper.dart';
import '../../../../data/datasource/static/static.dart';
import '../../Widgets/container.dart';
import '../../Widgets/form_fields.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class RegisterCompany extends StatelessWidget {
  const RegisterCompany({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var formKey2 = GlobalKey<FormState>();

    var companyNameController = TextEditingController();
    var websiteController = TextEditingController();
    var addressController = TextEditingController();
    var establishedDateController = TextEditingController();
    var emailController = TextEditingController();
    var phoneNumberController = TextEditingController();
    var industryController = TextEditingController();
    var startTimeController = TextEditingController();
    var endTimeController = TextEditingController();

    List<String> positions = [];
    List<String> depratments = [];

    return BlocProvider(
        create: (context) => AuthenticationCubit(),
        child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
          listener: (BuildContext context, Object? state) {
            if (state is RegisterCompanySuccessState) {
              if (state.registeCompanyrModel.status!) {
                CacheHelper.setData(key: 'loggedIn', value: true).then((value) {
                  final snackBar = SnackBar(
                    duration: const Duration(milliseconds: 1000),
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: '${state.registeCompanyrModel.status}',
                      message: '${state.registeCompanyrModel.message}',
                      contentType: ContentType.success,
                    ),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                  Get.offAllNamed(AppRoute.adminMainPage);
                });
              } else {
                final snackBar = SnackBar(
                  duration: const Duration(milliseconds: 1000),
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: '${state.registeCompanyrModel.status}',
                    message: '${state.registeCompanyrModel.message}',
                    contentType: ContentType.warning,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
            } else if (state is RegisterErrorState) {
              final snackBar = SnackBar(
                duration: const Duration(milliseconds: 2000),
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Error !',
                  message: 'Connection Timed Out!',
                  contentType: ContentType.failure,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          },
          builder: (BuildContext context, state) {
            var cubit = AuthenticationCubit.get(context);
            List<Step> getSteps() {
              return <Step>[
                Step(
                  state: cubit.currentStep > 0
                      ? StepState.complete
                      : StepState.indexed,
                  isActive: cubit.currentStep >= 0,
                  title: const Text("Company Info"),
                  content: Form(
                    key: formKey,
                    child: ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Row(children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(children: [
                                  CircleAvatar(
                                      //backgroundColor: AppColor.dashboardColor5,
                                      radius: 50,
                                      backgroundImage: cubit.imageFile != null
                                          ? Image.file(cubit.imageFile!).image
                                          : Image.asset(ImageAsset.companyLogo)
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
                                            child: const Icon(
                                              Icons.add_a_photo,
                                              color: AppColor.whiteColor,
                                              size: 16.0,
                                            )),
                                      ))
                                ]),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  textFormField(
                                    hintText: 'Resource Up',
                                    labelText: 'Company Name',
                                    controller: companyNameController,
                                    keyboardType: TextInputType.text,
                                    prefixIcon: Icons.house_outlined,
                                    validator: (value) =>
                                        validInput(value!, 5, 25, 'fullname'),
                                  ),
                                  const SizedBox(height: 6.0),
                                  textFormField(
                                    hintText: 'www.resourceup.com',
                                    labelText: 'Website',
                                    keyboardType: TextInputType.name,
                                    prefixIcon: FontAwesomeIcons.weebly,
                                    validator: (value) =>
                                        validInput(value!, 5, 100, 'website'),
                                    controller: websiteController,
                                  ),
                                ]),
                              ),
                            )
                          ]),
                          const Divider(thickness: 1, height: 32.0),
                          textFormField(
                            keyboardType: TextInputType.name,
                            validator: (value) =>
                                validInput(value!, 5, 100, 'address'),
                            prefixIcon: Icons.place_outlined,
                            controller: addressController,
                            hintText: 'Damascus,29 Street',
                            labelText: 'Address',
                            onTap: () {},
                          ),
                          const SizedBox(height: 6.0),
                          textFormField(
                            keyboardType: TextInputType.phone,
                            validator: (value) =>
                                validInput(value!, 5, 100, 'phone'),
                            prefixIcon: Icons.settings_phone_outlined,
                            controller: phoneNumberController,
                            hintText: '+123 456789',
                            labelText: 'Phone Number',
                            onTap: () {},
                          ),
                          const SizedBox(height: 6.0),
                          textFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                validInput(value!, 5, 100, 'email'),
                            prefixIcon: Icons.email_outlined,
                            controller: emailController,
                            hintText: 'info@resourceup.com',
                            labelText: 'E-mail',
                            onTap: () {},
                          ),
                          const SizedBox(height: 6.0),
                          textFormField(
                              keyboardType: TextInputType.none,
                              validator: (value) {
                                validInput(value!, 5, 100, 'date');
                                return null;
                              },
                              prefixIcon: Icons.date_range_outlined,
                              controller: establishedDateController,
                              hintText: establishedDateController.text,
                              labelText: 'Established Date',
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => SizedBox(
                                    height: 200,
                                    child: CupertinoDatePicker(
                                      backgroundColor: AppColor.whiteColor,
                                      initialDateTime: DateTime.now(),
                                      mode: CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (DateTime value) {
                                        establishedDateController.text =
                                            DateFormat("yyyy-MM-dd")
                                                .format(value);
                                      },
                                    ),
                                  ),
                                );
                              }),
                          const SizedBox(height: 20.0),
                        ]),
                  ),
                ),
                Step(
                  state: cubit.currentStep > 1
                      ? StepState.complete
                      : StepState.indexed,
                  isActive: cubit.currentStep >= 1,
                  title: const Text('Constraints'),
                  content: Form(
                      key: formKey2,
                      child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            dropDownButton(
                              dropDownList: industries,
                              selectedItem: 'Select Industry Type',
                              onChange: (selectedItem) {
                                industryController.text = selectedItem;
                              },
                            ),
                            const SizedBox(height: 12.0),
                            tagsField(
                                list: depratments,
                                hintText: 'Customer Service, Delivery....'),
                            const SizedBox(height: 12.0),
                            tagsField(
                                list: positions,
                                hintText:
                                    'Mobile Developer, Marketing Coodrinator...'),
                            const Divider(
                              thickness: 1,
                              height: 40,
                            ),
                            Text('Company working hours',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColor.primaryColor)),
                            const SizedBox(height: 12.0),
                            Row(
                              children: [
                                Expanded(
                                    child: textFormField(
                                        prefixIcon: Icons.date_range_outlined,
                                        controller: startTimeController,
                                        hintText: '08:00 Am',
                                        labelText: 'Start Time',
                                        keyboardType: TextInputType.none,
                                        validator: (value) {
                                          return null;
                                        },
                                        onTap: () {
                                          showCupertinoModalPopup(
                                            context: context,
                                            builder: (context) => SizedBox(
                                              height: 200,
                                              child: CupertinoDatePicker(
                                                backgroundColor:
                                                    AppColor.whiteColor,
                                                initialDateTime:
                                                    DateTime(0, 0, 0, 08, 00),
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                onDateTimeChanged:
                                                    (DateTime value) {
                                                  startTimeController.text =
                                                      DateFormat("hh:mm")
                                                          .format(value);
                                                },
                                              ),
                                            ),
                                          );
                                        })),
                                const SizedBox(width: 12.0),
                                Expanded(
                                    child: textFormField(
                                        prefixIcon: Icons.date_range_outlined,
                                        controller: endTimeController,
                                        hintText: '04:00 Pm',
                                        labelText: 'End Time',
                                        keyboardType: TextInputType.none,
                                        validator: (value) {
                                          return null;
                                        },
                                        onTap: () {
                                          showCupertinoModalPopup(
                                            context: context,
                                            builder: (context) => SizedBox(
                                              height: 200,
                                              child: CupertinoDatePicker(
                                                backgroundColor:
                                                    AppColor.whiteColor,
                                                initialDateTime:
                                                    DateTime(0, 0, 0, 04, 00),
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                onDateTimeChanged:
                                                    (DateTime value) {
                                                  endTimeController.text =
                                                      DateFormat("hh:mm")
                                                          .format(value);
                                                },
                                              ),
                                            ),
                                          );
                                        })),
                              ],
                            ),
                          ])),
                ),
              ];
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text('Continue Register'),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(color: AppColor.primaryColor),
                ),
                elevation: 0.0,
                backgroundColor: Colors.white,
              ),
              body: WillPopScope(
                onWillPop: exitAppAlert,
                child: radiusContainer(
                  radius: 25,
                  child: marginContainer(
                    horizontalMargin: 12.0,
                    child: Stepper(
                      type: StepperType.horizontal,
                      currentStep: cubit.currentStep,
                      onStepContinue: () {
                        if (formKey.currentState!.validate()) {
                          cubit.stepContinue();
                        }
                      },
                      onStepTapped: (step) {
                        if (formKey.currentState!.validate()) {
                          cubit.nextStep(step);
                        }
                      },
                      onStepCancel: cubit.previewsStep,
                      steps: getSteps(),
                      controlsBuilder: (context, controls) {
                        return Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextButton(
                                    onPressed: controls.onStepCancel,
                                    child: Text(
                                      'Previews',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: AppColor.greyColor3,
                                          ),
                                    )),
                              ),
                              Expanded(
                                child: ConditionalBuilder(
                                  condition: cubit.currentStep == 1,
                                  builder: (BuildContext context) =>
                                      ConditionalBuilder(
                                    condition:
                                        state is RegisterCompanyLoadingState,
                                    builder: (BuildContext context) =>
                                        circularProgressIndicator(),
                                    fallback: (BuildContext context) =>
                                        primaryButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                      .validate() &&
                                                  formKey2.currentState!
                                                      .validate()) {
                                                cubit.registerCompany(
                                                    companyName:
                                                        companyNameController
                                                            .text,
                                                    website:
                                                        websiteController.text,
                                                    address:
                                                        addressController.text,
                                                    establishedDate:
                                                        establishedDateController
                                                            .text,
                                                    typeOfIndustry:
                                                        industryController.text,
                                                    departments: depratments,
                                                    positions: positions,
                                                    startTime:
                                                        startTimeController
                                                            .text,
                                                    endTime:
                                                        endTimeController.text,
                                                    phoneNumber:
                                                        phoneNumberController
                                                            .text,
                                                    email:
                                                        emailController.text);
                                              }
                                            },
                                            text: 'Register'),
                                  ),
                                  fallback: (BuildContext context) =>
                                      TextButton(
                                    onPressed: controls.onStepContinue,
                                    child: Text(
                                      'Next',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: AppColor.primaryColor,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
