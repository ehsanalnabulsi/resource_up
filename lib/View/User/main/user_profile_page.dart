import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resource_up/View/Shared/Widgets/circular_progress_indicator.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../data/datasource/static/static.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            UserMainCubit()..fetchEmployeeDetails(),
        child: BlocConsumer<UserMainCubit, UserMainStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = UserMainCubit.get(context);
              // var theme = Theme.of(context).appBarTheme;
              return ConditionalBuilder(
                condition: state is GetUserInformationLoadingState,
                builder: (context) => circularProgressIndicator(),
                fallback: (context) => Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 35,
                                  child: ClipOval(
                                      child: Image.asset(ImageAsset.empImage))),
                              Container(
                                margin: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${cubit.employeeDetails['data']['fullName']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(),
                                    ),
                                    Text(
                                      '${cubit.employeeDetails['data']['positionsName']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              //color: AppColor.primaryColor,
                                              fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 2.0),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColor.greyColor1.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(25)),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColor.greyColor1.withOpacity(.6),
                            ),
                            padding: const EdgeInsets.all(20.0),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: profileListView.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  ListTile(
                                title: Text(profileListView[index].title),
                                subtitle: Text(profileListView[index].subtitle),
                                onTap: profileListView[index].onTap,
                                iconColor: AppColor.whiteColor,
                                leading: Container(
                                  decoration: BoxDecoration(
                                      color: profileListView[index].color,
                                      borderRadius: BorderRadius.circular(15)),
                                  width: 60,
                                  height: 60,
                                  child: profileListView[index].leading,
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: AppColor.greyColor3,
                                ),
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            children: const [
                              Text('  App Version'),
                              SizedBox(
                                width: 200,
                              ),
                              Text('1.0.0')
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
