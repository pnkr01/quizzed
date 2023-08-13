import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:install_plugin_v2/install_plugin_v2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quizzed/src/global/global.dart';
import 'package:quizzed/theme/gradient_theme.dart';
import '../../../theme/app_color.dart';
import '../../../utils/errordialog.dart';

class UpdateAppController extends GetxController {
  Future<void> downloadAndInstallUpdate(
      String apkUrl, BuildContext context) async {
    await Permission.storage.request();
    var permissions = await Permission.storage.status;
    if (permissions.isGranted) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Updating please wait :)'),
              SizedBox(height: 5),
              LinearProgressIndicator(
                color: kTeacherPrimaryColor,
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      );
      var request = await HttpClient().getUrl(Uri.parse(apkUrl));
      var response = await request.close();
      var path = (await getExternalStorageDirectory())?.path;
      var bytes = await consolidateHttpClientResponseBytes(response);
      await File('$path/quizzed.apk').writeAsBytes(bytes);
      Get.back();
      await InstallPlugin.installApk('$path/quizzed.apk', 'com.cdh.quiz')
          .then((result) {
        ('installed apk $result');
      }).catchError((error) {
        showSnackBar("Install apk error", redColor, whiteColor);
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => const ErrorDialog(
            message: 'We need storage permission to update this app'),
      );
    }
  }
}
