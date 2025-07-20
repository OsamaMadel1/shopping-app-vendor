import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionsRequester {
  /// طلب صلاحية الكاميرا
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) return true;
    final result = await Permission.camera.request();
    return result.isGranted;
  }

  /// طلب صلاحية التخزين/الصور حسب إصدار أندرويد
  static Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      // Android 13+ (API 33+): استخدم صلاحيات الوسائط الجديدة
      if (await Permission.photos.isGranted ||
          await Permission.videos.isGranted) {
        return true;
      }

      if (await Permission.photos.request().isGranted ||
          await Permission.videos.request().isGranted) {
        return true;
      }

      // Android 12 وأقل (API 32-): استخدم صلاحية التخزين التقليدية
      final storageStatus = await Permission.storage.status;
      if (storageStatus.isGranted) return true;
      final storageResult = await Permission.storage.request();
      return storageResult.isGranted;
    } else if (Platform.isIOS) {
      final result = await Permission.photos.request();
      return result.isGranted;
    } else {
      return false;
    }
  }

  /// طلب الصلاحيتين معًا
  static Future<bool> requestCameraAndStoragePermissions() async {
    final camera = await requestCameraPermission();
    final storage = await requestStoragePermission();
    return camera && storage;
  }
}
