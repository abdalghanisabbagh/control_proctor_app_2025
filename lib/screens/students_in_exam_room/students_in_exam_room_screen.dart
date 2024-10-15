import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../controllers/controllers.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../resource_manager/ReusableWidget/show_dialogue.dart';

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
        iconTheme: const IconThemeData(
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
                              onPressed: () {
                                controller.locked
                                    ? MyDialogs.showDialog(
                                        context,
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                ),
                                              ),
                                            ),
                                            MyTextFormFiled(
                                              title: 'Enter The Password',
                                              controller:
                                                  controller.passwordController,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            controller.validating
                                                ? Center(
                                                    child: FittedBox(
                                                      fit: BoxFit.cover,
                                                      child: LoadingIndicators
                                                          .getLoadingIndicator(),
                                                    ),
                                                  )
                                                : ElevatedButton(
                                                    onPressed: () async {
                                                      controller.unlock();
                                                    },
                                                    child:
                                                        const Text('Validate'),
                                                  ),
                                          ],
                                        ),
                                      )
                                    : {
                                        controller.locked = true,
                                        controller.update(),
                                      };
                              },
                              icon: controller.locked
                                  ? const Icon(Icons.lock_outline)
                                  : const Icon(Icons.lock_open_outlined),
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
                                GestureDetector(
                                  onTap: () {
                                    if (!controller.locked) {
                                      MyAwesomeDialogue(
                                        title:
                                            'This will Mark/Unmark the Student as Cheating',
                                        desc: 'Are you sure?',
                                        dialogType: DialogType.warning,
                                        btnOkOnPressed: () {
                                          controller
                                                      .studentBarcodeInExamRoom!
                                                      .barcodesResModel!
                                                      .barcodes![i]
                                                      .isCheating ==
                                                  0
                                              ? controller.markStudentCheating(
                                                  barcode: controller
                                                      .studentBarcodeInExamRoom!
                                                      .barcodesResModel!
                                                      .barcodes![i]
                                                      .barcode!)
                                              : controller.unMarkCheatingStudent(
                                                  barcode: controller
                                                      .studentBarcodeInExamRoom!
                                                      .barcodesResModel!
                                                      .barcodes![i]
                                                      .barcode!);
                                        },
                                        btnCancelOnPressed: () {},
                                      ).showDialogue(Get.key.currentContext!);
                                    }
                                  },
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
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
                                                  color: ColorManager.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: controller
                                                          .studentBarcodeInExamRoom!
                                                          .barcodesResModel!
                                                          .barcodes![i]
                                                          .isCheating! ==
                                                      1
                                                  ? ColorManager.ornage
                                                  : controller
                                                              .studentBarcodeInExamRoom!
                                                              .barcodesResModel!
                                                              .barcodes![i]
                                                              .attendanceStatusId ==
                                                          13
                                                      ? ColorManager.green
                                                      : ColorManager.greyA8,
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
                                                      color:
                                                          ColorManager.black),
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
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
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
                                                      .firstName
                                                      .toString(),
                                                  style: nunitoRegularStyle(
                                                    fontSize: FontSize.s18,
                                                    color: ColorManager.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
