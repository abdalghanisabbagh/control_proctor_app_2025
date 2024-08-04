import 'package:control_proctor/controllers/controllers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../resource_manager/color_manager.dart';
import '../../resource_manager/font_manager.dart';
import '../../resource_manager/styles_manager.dart';

class StudentsInExamRoomScreen extends GetView<StudentsInExamRoomController> {
  const StudentsInExamRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        backgroundColor: ColorManager.bgSideMenu,
        titleTextStyle: nunitoRegularStyle(
          fontSize: FontSize.s18,
          color: ColorManager.white,
        ),
        iconTheme: IconThemeData(
          color: ColorManager.white,
        ),
      ),
      body: GetBuilder<StudentsInExamRoomController>(
        builder: (controller) {
          return controller.isLoading
              ? Center(
                  child: LoadingIndicators.getLoadingIndicator(),
                )
              : controller.studentBarcodeInExamRoom != null
                  ? Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton.outlined(
                              onPressed: () async {
                                String? uuid /* , studentId, name, examId */;
                                dynamic result;
                                if (kIsWeb) {
                                  result = await Navigator.push(
                                    Get.overlayContext!,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SimpleBarcodeScannerPage(
                                        scanType: ScanType.qr,
                                        appBarTitle: 'Student QR code',
                                      ),
                                    ),
                                  );
                                  if (result is String) {
                                    var res = result;
                                    var splitedData = res.split('\n');
                                    MyFlashBar.showSuccess(
                                            splitedData[0].toString(),
                                            'Scanned Successfully')
                                        .show(Get.key.currentContext!);
                                    uuid = splitedData[1];
                                    await controller
                                        .activateStudent(int.parse(uuid));
                                    // macId = splitedData.first;
                                    // studentId = splitedData[1];
                                    // name = splitedData[2];
                                    // examId = splitedData.last;
                                  } else {
                                    // student_loading = false;
                                    // isScanning = false;
                                    // update();
                                    return;
                                  }
                                }
                              },
                              icon: const Icon(
                                Icons.qr_code_scanner_outlined,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.lock_outline,
                              ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 20, vertical: 10),
                        Expanded(
                          child: GridView(
                            padding: const EdgeInsets.all(20),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            children: [
                              for (int i = 0;
                                  i <
                                      controller.studentBarcodeInExamRoom!
                                          .barcodesResModel!.barcodes!.length;
                                  i++)
                                Card(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            color: ColorManager.primary,
                                          ),
                                          child: Center(
                                            child: Text(
                                              controller
                                                  .studentBarcodeInExamRoom!
                                                  .barcodesResModel!
                                                  .barcodes![i]
                                                  .studentSeatNumberResModel!
                                                  .seatNumber
                                                  .toString(),
                                              style: nunitoRegularStyle(
                                                fontSize: FontSize.s18,
                                                color: ColorManager.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: ColorManager.gradesColor[
                                                controller
                                                    .studentBarcodeInExamRoom!
                                                    .barcodesResModel!
                                                    .barcodes![i]
                                                    .student!
                                                    .gradeResModel!
                                                    .name!],
                                          ),
                                          child: Center(
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Text(
                                                controller
                                                    .studentBarcodeInExamRoom!
                                                    .barcodesResModel!
                                                    .barcodes![i]
                                                    .student!
                                                    .gradeResModel!
                                                    .name!,
                                                style: nunitoRegularStyle(
                                                  fontSize: FontSize.s18,
                                                  color: ColorManager.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                            color: ColorManager.bgSideMenu,
                                          ),
                                          child: Center(
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Text(
                                                controller
                                                    .studentBarcodeInExamRoom!
                                                    .barcodesResModel!
                                                    .barcodes![i]
                                                    .student!
                                                    .firstName
                                                    .toString(),
                                                style: nunitoRegularStyle(
                                                  fontSize: FontSize.s18,
                                                  color: ColorManager.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const Center();
        },
      ),
    );
  }
}
