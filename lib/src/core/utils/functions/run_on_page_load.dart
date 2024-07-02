import 'package:flutter/material.dart';

void onPageLoaded(Function callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}
