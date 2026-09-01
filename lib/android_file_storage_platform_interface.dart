import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'android_file_storage_method_channel.dart';

abstract class AndroidFileStoragePlatform extends PlatformInterface {
  AndroidFileStoragePlatform() : super(token: _token);

  static final Object _token = Object();
  static AndroidFileStoragePlatform _instance =
      MethodChannelAndroidFileStorage();

  static AndroidFileStoragePlatform get instance => _instance;
  static set instance(AndroidFileStoragePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> saveFile({
    required String fileName,
    required List<int> bytes,
    required String mimeType,
    String? subFolder, // New parameter
  }) {
    throw UnimplementedError('saveFile() has not been implemented.');
  }
}
