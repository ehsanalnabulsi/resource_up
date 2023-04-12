import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resource_up/View/Shared/Widgets/container.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../data/datasource/static/static.dart';
import '../../Shared/Widgets/circular_progress_indicator.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            AdminMainCubit()..getUserInformation(),
        child: BlocConsumer<AdminMainCubit, AdminMainStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AdminMainCubit.get(context);
              // var theme = Theme.of(context).appBarTheme;
              return ConditionalBuilder(
                  condition: state is GetUserInformationLoadingState,
                  builder: (BuildContext context) =>
                      Center(child: circularProgressIndicator()),
                  fallback: (BuildContext context) => Center(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 30,
                                    child: ClipOval(
                                        child: Image.asset(
                                            ImageAsset.defaultAvatar)),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${cubit.userModel.data!.fullName}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color: AppColor.primaryColor),
                                        ),
                                        Text('HR Manager',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium)
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.greyColor1
                                            .withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            heightSizedBox(),
                            listTileBuilder(),
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
                      ));
            }));
  }

  Widget listTileBuilder() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColor.greyColor1.withOpacity(.6),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: profileListView.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
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
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      );
}
