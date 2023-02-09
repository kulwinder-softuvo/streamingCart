import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> handlePermissionsForCall(BuildContext context) async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.microphone,
    Permission.storage,
  ].request();

  if (statuses[Permission.storage]!.isPermanentlyDenied) {
    showCustomDialog("Permission Required",
        "Storage Permission Required for Video Call", () {
      Navigator.pop(context);
      openAppSettings();
    });
    return false;
  } else if (statuses[Permission.camera]!.isPermanentlyDenied) {
    showCustomDialog("Permission Required",
        "Camera Permission Required for Video Call", () {
      Navigator.pop(context);
      openAppSettings();
    });
    return false;
  } else if (statuses[Permission.microphone]!.isPermanentlyDenied) {
    showCustomDialog("Permission Required",
        "Microphone Permission Required for Video Call", () {
      Navigator.pop(context);
      openAppSettings();
    });
    return false;
  }

  if (statuses[Permission.storage]!.isDenied) {
    return false;
  } else if (statuses[Permission.camera]!.isDenied) {
    return false;
  } else if (statuses[Permission.microphone]!.isDenied) {
    return false;
  }
  return true;
}

void showCustomDialog(String title, String message,
    Function okPressed) async {
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog

      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'WorkSansMedium'),
        ),
        content:  Text(
          message,
          style: const TextStyle(fontFamily: 'WorkSansMedium'),
        ),
        actions: <Widget>[
          ElevatedButton(
              child: const Text("OK"), onPressed: () => {okPressed()}),
        ],
      );
    },
  );
}

String generateRandomNum(int len, bool isChar) {
  var r = Random();
  var chars = "";
  if (isChar) {
    chars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890";
  } else {
    chars = "1234567890";
  }
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}
