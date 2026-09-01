import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'android_file_storage_platform_interface.dart';

class MethodChannelAndroidFileStorage extends AndroidFileStoragePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('android_file_storage');

  @override
  Future<String?> saveFile({
    required String fileName,
    required List<int> bytes,
    required String mimeType,
  }) async {
    final String? uriResult = await methodChannel.invokeMethod<String>(
      'saveFile',
      <String, dynamic>{
        'fileName': fileName,
        'bytes': Uint8List.fromList(bytes),
        'mimeType': mimeType,
      },
    );
    return uriResult;
  }
}
