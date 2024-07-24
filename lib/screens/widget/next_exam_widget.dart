import 'package:control_proctor/controller/next_exam_controller.dart';
import 'package:control_proctor/models/next%20exam/next_exam_res_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resource_manager/color_manager.dart';

// ignore: must_be_immutable
class NextExamWidget extends GetView<NextExamController> {
  final NextExamResModel nextExamResModel;

  const NextExamWidget({
    super.key,
    required this.nextExamResModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Room: ${nextExamResModel.examRoomResModel!.name!}",
                      style: const TextStyle(
                        color: ColorManager.primary,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    // GetBuilder<CoversSheetsController>(
                    //     builder: (coversSheetsController) {
                    //   return IconButton(
                    //     onPressed: () {
                    //       MyAwesomeDialogue(
                    //         title: 'Delete Exam Cover Sheet',
                    //         desc:
                    //             'Are you sure you want to delete this mission?',
                    //         dialogType: DialogType.warning,
                    //         btnCancelOnPressed: () {},
                    //         btnOkOnPressed: () {
                    //           coversSheetsController
                    //               .deleteExamMission(id: examMissionObject.iD!)
                    //               .then((value) {
                    //             if (value) {
                    //               MyFlashBar.showSuccess(
                    //                 'Success',
                    //                 'Students have been distributed successfully',
                    //               ).show(context);
                    //             }
                    //           });
                    //         },
                    //       ).showDialogue(context);
                    //     },
                    //     icon: CircleAvatar(
                    //       backgroundColor: ColorManager.red,
                    //       child: Icon(
                    //         Icons.delete_forever,
                    //         color: ColorManager.white,
                    //       ),
                    //     ),
                    //   );
                    // }),
                  ],
                ),
              ],
            ),
          ),
          // controller.isLoadingGeneratePdf
          //     ? Center(
          //         child: SizedBox(
          //           height: 50,
          //           width: 50,
          //           child: FittedBox(
          //             child: LoadingIndicators.getLoadingIndicator(),
          //           ),
          //         ),
          //       )
          //     : InkWell(
          //         onTap: () {
          //           controller.generatePdfSeatNumber(
          //               gradeId: examMissionObject.gradesID!,
          //               controlMissionName: controlMissionObject.name!,
          //               controlMissionId: controlMissionObject.iD!);
          //         },
          //         child: Container(
          //           height: 50,
          //           width: double.infinity,
          //           decoration: BoxDecoration(
          //             borderRadius: const BorderRadius.only(
          //               bottomLeft: Radius.circular(10),
          //               bottomRight: Radius.circular(10),
          //             ),
          //             color: ColorManager.bgSideMenu,
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               const Text("Generate Pdf"),
          //               const SizedBox(width: 20),
          //               Icon(Icons.print, color: ColorManager.white),
          //             ],
          //           ),
          //         ),
          //       )
        ],
      ),
    );
  }
}
