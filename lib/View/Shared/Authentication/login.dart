import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/routes.dart';
import '../../../core/functions/dialogs.dart';
import '../../../core/functions/validator.dart';
import '../../../core/services/local/cache_helper.dart';
import '../Widgets/buttons.dart';
import '../Widgets/container.dart';
import '../Widgets/form_fields.dart';
import '../Widgets/logo.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
        create: (context) => AuthenticationCubit(),
        child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              if (state.loginModel.status!) {
                CacheHelper.setData(
                        key: 'token', value: state.loginModel.data!.access)
                    .then((value) {
                  final snackBar = SnackBar(
                    duration: const Duration(milliseconds: 1000),
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: '${state.loginModel.status}',
                      message: '${state.loginModel.message}',
                      contentType: ContentType.success,
                    ),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                  CacheHelper.setData(
                      key: 'isHr', value: state.loginModel.data!.isHr);
                  Get.offAllNamed(state.loginModel.data!.isHr == true
                      ? AppRoute.adminMainPage
                      : AppRoute.userMainPage);
                });
              } else {
                final snackBar = SnackBar(
                  duration: const Duration(milliseconds: 1000),
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: '${state.loginModel.status}',
                    message: '${state.loginModel.message}',
                    contentType: ContentType.warning,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
            } else if (state is LoginErrorState) {
              final snackBar = SnackBar(
                duration: const Duration(milliseconds: 1000),
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Error !',
                  message: 'Connection Timed Out',
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
                    title: const Text(
                      "Log In",
                      style: TextStyle(fontSize: 24),
                    ),
                    centerTitle: true,
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
                        child: Center(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Form(
                              key: formKey,
                              child: Column(children: [
                                SizedBox(height: 60, child: logoImage()),
                                const SizedBox(height: 50),
                                Text('Welcome Back',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge),
                                const SizedBox(height: 20),
                                Text(
                                    'Log in now and make your\nattendance easily and fast ',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                const SizedBox(height: 40),
                                textFormField(
                                  hintText: 'Enter Your Username',
                                  labelText: 'Username',
                                  controller: usernameController,
                                  keyboardType: TextInputType.text,
                                  prefixIcon: Icons.person,
                                  validator: (String? value) =>
                                      validInput(value!, 5, 100, 'usasername'),
                                ),
                                const SizedBox(height: 16.0),
                                textFormField(
                                  hintText: 'Enter Your Password',
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
                                const SizedBox(height: 15),
                                InkWell(
                                  onTap: () {},
                                  child: const Text(
                                    "Forget Password ?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                                const SizedBox(height: 80),
                                ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder: (context) => primaryButton(
                                      text: 'Log In',
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.userLogin(
                                              username: usernameController.text,
                                              password:
                                                  passwordController.text);
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
                                    Text("Dont have an account?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                    InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRoute.register);
                                        },
                                        child: Text(
                                          " Register",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color: AppColor.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    )));
          },
        ));
  }
}
