import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfwidgets;

import 'package:resource_up/View/Admin/PayrollsManagment/cubit/states.dart';

import '../../../../data/model/salary_model.dart';

class PayrollsCubit extends Cubit<PayrollsStates> {
  PayrollsCubit() : super(GetPayrollsListInitialState());
  static PayrollsCubit get(context) => BlocProvider.of(context);

  Future<void> generatePdf(List<SalaryModel> salarySheetData) async {
    final pdf = pdfwidgets.Document();

    // Add a page to the document
    pdf.addPage(
      pdfwidgets.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pdfwidgets.ListView(
            children: [
              pdfwidgets.Text('Salary Sheet'),
              pdfwidgets.SizedBox(height: 20),
              pdfwidgets.Table(
                children: [],
              ),
            ],
          );
        },
      ),
    );

    // Get the directory for saving the PDF file
    final directory = await getExternalStorageDirectory();
    final path = '${directory!.path}/salary_sheet.pdf';

    // Save the PDF file
    final file = File(path);
    await file.writeAsBytes(await pdf.save());
  }
}
