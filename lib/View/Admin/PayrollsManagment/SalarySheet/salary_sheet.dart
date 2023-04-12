import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';


import '../../../../core/constant/app_color.dart';
import '../../../../data/datasource/static/static.dart';
import '../../../Shared/Widgets/container.dart';
import '../../../Shared/Widgets/form_fields.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class SalarySheet extends StatelessWidget {
  const SalarySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PayrollsCubit(),
        child: BlocConsumer<PayrollsCubit, PayrollsStates>(
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
                    'Salary Sheet',
                    style: TextStyle(
                      // fontFamily: 'PlayfairDisplay',
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
                body: radiusContainer(
                    child: marginContainer(
                        child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'Salary Sheet For',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 22.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                              child: dropDownButton(
                                  dropDownList: months,
                                  selectedItem: Jiffy(DateTime.now()).MMMM))
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Base Salary')),
                            DataColumn(label: Text('Bonuses')),
                            DataColumn(label: Text('Deductions')),
                            DataColumn(label: Text('Total')),
                          ],
                          rows: salarySheetData
                              .map(
                                (sheet) => DataRow(
                                  cells: [
                                    DataCell(Text(sheet.employeeName ?? '')),
                                    DataCell(Text(
                                        sheet.baseSalary?.toStringAsFixed(2) ??
                                            '')),
                                    DataCell(Text(
                                        sheet.bonuses?.toStringAsFixed(2) ??
                                            '')),
                                    DataCell(Text(
                                        sheet.deductions?.toStringAsFixed(2) ??
                                            '')),
                                    DataCell(Text(
                                        sheet.totalSalary?.toStringAsFixed(2) ??
                                            '')),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    )
                  ],
                ))),
              );
            }));
  }
}
