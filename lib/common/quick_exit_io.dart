import 'dart:io';
import 'package:flutter/services.dart';

void quickExit() {
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else {
    exit(0);
  }
}
