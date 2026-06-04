import 'dart:io';
import 'package:flutter/services.dart';

class NativePdfService {
  static const MethodChannel _channel =
  MethodChannel('native_pdf');

  static Future<String?> generateTamilPdf(Map<String, dynamic> data) async {
    try {
      final String path =
      await _channel.invokeMethod('generateTamilPdf', data);
      return path;
    } catch (e) {
      print('Native PDF error: $e');
      return null;
    }
  }
}
///