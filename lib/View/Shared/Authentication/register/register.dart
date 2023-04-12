import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:intl/intl.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/functions/dialogs.dart';
import '../../../../core/functions/validator.dart';
import '../../../../core/services/local/cache_helper.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/container.dart';
import '../../Widgets/form_fields.dart';
import '../../Widgets/logo.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var fullnameController = TextEditingController();
    var emailController = TextEditingController();
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();
    var birthdateController = TextEditingController();
    var genderController = TextEditingController(text: 'Male');

    // var usernameController = TextEditingController();
    return BlocProvider(
        create: (context) => AuthenticationCubit(),
        child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
          listener: (BuildContext context, Object? state) {
            if (state is RegisterSuccessState) {
              if (state.registerModel.status!) {
                // CacheHelper.setData(
                //         key: 'token', value: state.registerModel.data!.access)
                //     .then((value) {

                final snackBar = SnackBar(
                  duration: const Duration(milliseconds: 1000),
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: '${state.registerModel.status}',
                    message: '${state.registerModel.message}',
                    contentType: ContentType.success,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
                AuthenticationCubit.get(context).userLogin(
                    username: usernameController.text,
                    password: passwordController.text);

                // });
              } else {
                final snackBar = SnackBar(
                  duration: const Duration(milliseconds: 1000),
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: '${state.registerModel.status}',
                    message: '${state.registerModel.message}',
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
            return Scaffold(
                appBar: AppBar(
                    flexibleSpace: Container(
                      decoration:
                          const BoxDecoration(color: AppColor.primaryColor),
                    ),
                    elevation: 0.0,
                    backgroundColor: AppColor.whiteColor),
                body: WillPopScope(
                    onWillPop: exitAppAlert,
                    child: radiusContainer(
                        child: marginContainer(
                      child: Form(
                        key: formKey,
                        child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              const SizedBox(height: 12.0),
                              SizedBox(height: 60, child: logoImage()),
                              const SizedBox(height: 12.0),
                              const Text('Register as Mangaer / HR',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.black)),
                              const SizedBox(height: 12.0),
                              textFormField(
                                  hintText: 'Ehsan AL-Nabulsi',
                                  labelText: 'Owner/Admin Name',
                                  controller: fullnameController,
                                  keyboardType: TextInputType.name,
                                  prefixIcon: Icons.person_outline_outlined,
                                  validator: (String? value) =>
                                      validInput(value!, 5, 100, 'fullname')),
                              const SizedBox(height: 12.0),
                              textFormField(
                                  hintText: 'ehsannabulsi5@gmail.com',
                                  labelText: 'Email',
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: Icons.email_outlined,
                                  validator: (String? value) =>
                                      validInput(value!, 5, 100, 'email')),
                              const SizedBox(height: 12.0),
                              textFormField(
                                  hintText: 'ehsanalnabulsi',
                                  labelText: 'Username',
                                  controller: usernameController,
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: Icons.person_outline_outlined,
                                  validator: (String? value) =>
                                      validInput(value!, 5, 100, 'username')),
                              const SizedBox(height: 12.0),
                              textFormField(
                                hintText: '***********',
                                labelText: 'Password',
                                keyboardType: TextInputType.visiblePassword,
                                prefixIcon: Icons.lock_outlined,
                                isPassowrd: cubit.isPassword,
                                suffixIcon: cubit.suffix,
                                suffixPressed: () =>
                                    cubit.changePasswordVisibility(),
                                validator: (value) =>
                                    validInput(value!, 5, 100, 'password'),
                                controller: passwordController,
                              ),
                              const Divider(thickness: 1, height: 24.0),
                              Text('Gender & Birth Date',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: CupertinoRadioChoice(
                                        notSelectedColor: AppColor.greyColor3,
                                        selectedColor: AppColor.primaryColor,
                                        choices: const {
                                          'Male': 'Male',
                                          'Female': 'Female',
                                        },
                                        onChange: (selectedGender) {
                                          genderController.text =
                                              selectedGender;
                                        },
                                        initialKeyValue: 'Male'),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: textFormField(
                                      keyboardType: TextInputType.none,
                                      validator: (value) {
                                        return null;
                                      },
                                      prefixIcon: Icons.date_range_outlined,
                                      controller: birthdateController,
                                      hintText: birthdateController.text,
                                      onTap: () {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) => SizedBox(
                                            height: 200,
                                            child: CupertinoDatePicker(
                                              backgroundColor:
                                                  AppColor.whiteColor,
                                              initialDateTime: DateTime.now(),
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              onDateTimeChanged:
                                                  (DateTime value) {
                                                birthdateController.text =
                                                    DateFormat("yyyy-MM-dd")
                                                        .format(value);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                      "By clicking Register,you agree to our",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      )),
                                  InkWell(
                                    onTap: () {
                                      // Get.toNamed(AppRoute.signin);
                                    },
                                    child: const Text(
                                      " Terms and Policies",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primaryColor,
                                          fontSize: 13,
                                          fontFamily: 'P'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12.0),
                              ConditionalBuilder(
                                condition: state is! RegisterLoadingState,
                                builder: (context) => primaryButton(
                                    text: 'Register',
                                    width: 100,
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.userRegister(
                                          fullName: fullnameController.text,
                                          email: emailController.text,
                                          username: usernameController.text,
                                          password: passwordController.text,
                                          gender: genderController.text,
                                          birthDate: birthdateController.text,
                                        );
                                      }
                                    }),
                                fallback: (context) => const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have account?",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      )),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRoute.login);
                                    },
                                    child: const Text(
                                      " Log In",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ))));
          },
        ));
  }
}
