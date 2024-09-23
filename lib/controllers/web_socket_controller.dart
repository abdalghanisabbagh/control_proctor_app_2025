import 'package:control_proctor/configurations/app_links.dart';
import 'package:control_proctor/routes_manger.dart';
import 'package:control_proctor/services/token_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class WebSocketController extends GetxController {
  late io.Socket socket;

  void closeSocket() {
    socket.dispose();
  }

  void initSocket() {
    socket = io.io(
      AppLinks.baseUrlDev,
      io.OptionBuilder()
          .setAuth(
            {
              'Authorization':
                  'Bearer ${Get.find<TokenService>().tokenModel?.aToken}',
            },
          )
          .setTransports(['websocket']) // for Flutter or Dart VM
          .enableAutoConnect() // enable auto-connection
          .build(),
    )
      ..onConnect(
        (_) {},
      )
      ..onDisconnect(
        (_) {
          Get.delete<WebSocketController>(force: true);
          Get.offAllNamed(Routes.initialRoute);
        },
      )
      ..on(
        'error',
        (error) {
          if (error['status'] == 400) {
            Get.delete<WebSocketController>(force: true);
            Get.offAllNamed(Routes.initialRoute);
          }
        },
      )
      ..on(
        'room_event',
        (roomEvent) {
          if (roomEvent['eventType'] == 1) {
            debugPrint('room_event: $roomEvent');
          } else if (roomEvent['eventType'] == 0) {
            debugPrint('room_event: $roomEvent');
          }
        },
      );
  }

  @override
  void onClose() {
    closeSocket();
    super.onClose();
  }

  @override
  void onInit() {
    initSocket();
    super.onInit();
  }
}
