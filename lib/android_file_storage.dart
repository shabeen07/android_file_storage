import 'android_file_storage_platform_interface.dart';

class AndroidFileStorage {
  Future<String?> saveFile({
    required String fileName,
    required List<int> bytes,
    required String mimeType,
    String? subFolder, // New parameter
  }) {
    return AndroidFileStoragePlatform.instance.saveFile(
      fileName: fileName,
      bytes: bytes,
      mimeType: mimeType,
      subFolder: subFolder,
    );
  }
}
