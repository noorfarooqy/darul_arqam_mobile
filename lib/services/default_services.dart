import 'package:flutter/material.dart';

class DefaultServices {
  String errorMessage = '';
  bool errorStatus = false;

  setError(e) {
    errorMessage = e;
    errorStatus = true;
  }
}
