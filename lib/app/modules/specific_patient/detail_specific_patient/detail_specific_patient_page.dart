import 'package:flutter/material.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DetailSpecificPatientPage extends StatelessWidget {
  const DetailSpecificPatientPage({Key? key, this.urlPdf}) : super(key: key);
  final String? urlPdf;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Phiếu chỉ định',
      ),
      body: SfPdfViewer.network((urlPdf??''),
    ));
  }
}