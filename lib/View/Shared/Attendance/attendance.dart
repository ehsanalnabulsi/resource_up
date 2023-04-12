import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resource_up/View/Shared/Attendance/cubit/cubit.dart';
import 'package:resource_up/View/Shared/Attendance/cubit/states.dart';
import 'package:resource_up/View/Shared/Widgets/circular_progress_indicator.dart';
import 'package:resource_up/View/Shared/Widgets/container.dart';

import 'package:jiffy/jiffy.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/functions/greeting.dart';
import '../Widgets/digital_clock.dart';

class Attendance extends StatelessWidget {
  const Attendance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AttendanceCubit()..getAttendanceInfo(),
        child: BlocConsumer<AttendanceCubit, AttendanceStates>(
            listener: (BuildContext context, Object? state) {},
            builder: (BuildContext context, state) {
              var cubit = AttendanceCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  flexibleSpace: Container(
                    decoration:
                        const BoxDecoration(color: AppColor.primaryColor),
                  ),
                  title: const Text(
                    'Attendance',
                    style: TextStyle(
                      // fontFamily: 'PlayfairDisplay',
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
                body: Container(
                  decoration: const BoxDecoration(color: AppColor.primaryColor),
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: radiusContainer(
                      child: marginContainer(
                          child: ConditionalBuilder(
                        condition: state is AttendanceLoadingState,
                        builder: (context) => circularProgressIndicator(),
                        fallback: (context) => SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 35,
                                          child: ClipOval(
                                              child: Image.asset(
                                                  ImageAsset.empImage))),
                                      Container(
                                        margin: const EdgeInsets.all(16.0),
                                        child: Text(
                                          cubit.attendanceUser['fullName'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              digitalClock(),
                              Text(Jiffy(DateTime.now()).yMMMMEEEEd,
                                  style: const TextStyle(fontSize: 18)),
                              const SizedBox(height: 30),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        '   Today\'s Status',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: AppColor.primaryColor),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(6.0),
                                                child: Text(
                                                  'Check In',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                              ),
                                              const FaIcon(
                                                  FontAwesomeIcons.clock,
                                                  color: AppColor.primaryColor),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Text(
                                                  cubit.attendanceUser[
                                                      'checkIn'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Check Out',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                              ),
                                              const FaIcon(
                                                  FontAwesomeIcons.clock,
                                                  color: AppColor.primaryColor),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  cubit.attendanceUser[
                                                      'checkOut'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Work Time',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                              ),
                                              const FaIcon(
                                                  FontAwesomeIcons
                                                      .clockRotateLeft,
                                                  color: AppColor.primaryColor),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  cubit.attendanceUser[
                                                      'workTime'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //  ),

                              const SizedBox(height: 30),
                              ConditionalBuilder(
                                condition: cubit.attendanceUser['dayEnd'],
                                builder: (context) => Center(
                                    child: Text(
                                  cubit.attendanceUser['message'],
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                )),
                                fallback: (context) => Builder(
                                  builder: (context) {
                                    final GlobalKey<SlideActionState> key =
                                        GlobalKey();
                                    return SlideAction(
                                      text: cubit.attendanceUser['message'],
                                      borderRadius: 50.0,
                                      elevation: 5.0,
                                      key: key,
                                      onSubmit: () {
                                        cubit.scanBarcode();
                                        // Future.delayed(
                                        //   const Duration(seconds: 2),
                                        //   () => key.currentState?.reset(),
                                        // );
                                      },
                                      innerColor: AppColor.primaryColor,
                                      outerColor: Colors.white,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                    ),
                  ),
                ),
              );
            }));
  }
}
