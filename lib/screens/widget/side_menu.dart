import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/side_menu_controller.dart';
import '../../resource_manager/assets_manager.dart';
import '../../resource_manager/color_manager.dart';
import '../../routes_manger.dart';

class SideMenu extends StatelessWidget {
  SideMenu({super.key});
  final SideMenuController sideMenuController = Get.put(SideMenuController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width * 0.5,
      child: Column(
        children: <Widget>[
          Container(
            color: ColorManager.primary, // اللون العلوي
            height: Get.height * 0.3,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.2,
                  width: Get.width * 0.4,
                  child: Image.asset(AssetsManager.assetsLogosNIS5),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Welcome To Control Proctor",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white, // اللون السفلي
              child: Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          const Divider(
                            color: ColorManager.primary,
                            thickness: 3,
                          ),
                          _buildListTile(
                            icon: Icons.pageview,
                            title: 'Next Exams',
                            pageName: '/NextExams',
                          ),
                          _buildListTile(
                            icon: Icons.pages,
                            title: 'All Exams',
                            pageName: '/AllExams',
                          ),
                          _buildListTile(
                            icon: Icons.pageview,
                            title: 'Attendance',
                            pageName: '/Attendance',
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Logout'),
                    onTap: () {
                      // Handle logout action
                      Get.toNamed(Routes.loginRoute); // Close the drawer
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildListTile({
    required IconData icon,
    required String title,
    required String pageName,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      tileColor: sideMenuController.currentPage.value == pageName
          ? Colors.grey[300] // لون الخلفية للصفحة النشطة
          : null,
      onTap: () {
        sideMenuController.updatePage(pageName);
        Get.toNamed(pageName);
      },
      shape: sideMenuController.currentPage.value == pageName
          ? RoundedRectangleBorder(
              side: const BorderSide(color: ColorManager.primary, width: 2),
              borderRadius: BorderRadius.circular(5),
            )
          : null,
    );
  }
}
