import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/app_color.dart';
import '../../../data/datasource/static/static.dart';
import '../../Shared/Widgets/container.dart';
import '../../Shared/Widgets/form_fields.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ApplyRequest extends StatelessWidget {
  const ApplyRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserRequestsCubit(),
        child: BlocConsumer<UserRequestsCubit, UserRequestsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.print_outlined,
                      size: 24.0,
                    ),
                  ),
                  appBar: AppBar(
                    flexibleSpace: Container(
                      decoration:
                          const BoxDecoration(color: AppColor.primaryColor),
                    ),
                    title: const Text(
                      'Apply New Request',
                      style: TextStyle(
                        // fontFamily: 'PlayfairDisplay',
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                  body: radiusContainer(
                      child: marginContainer(child: Container())));
            }));
  }
}
