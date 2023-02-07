import 'dart:math';

import 'package:flutter/cupertino.dart';
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
    showCustomDialog(context, "Permission Required",
        "Storage Permission Required for Video Call", () {
      Navigator.pop(context);
      openAppSettings();
    });
    return false;
  } else if (statuses[Permission.camera]!.isPermanentlyDenied) {
    showCustomDialog(context, "Permission Required",
        "Camera Permission Required for Video Call", () {
      Navigator.pop(context);
      openAppSettings();
    });
    return false;
  } else if (statuses[Permission.microphone]!.isPermanentlyDenied) {
    showCustomDialog(context, "Permission Required",
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

void showCustomDialog(BuildContext context, String title, String message,
    Function okPressed) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog

      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: new Text(
          title,
          style: TextStyle(fontFamily: 'WorkSansMedium'),
        ),
        content: new Text(
          message,
          style: TextStyle(fontFamily: 'WorkSansMedium'),
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
  var _chars = "";
  if (isChar)
    _chars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890";
  else
    _chars = "1234567890";
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}
