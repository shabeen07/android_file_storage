import 'package:android_file_storage/android_file_storage.dart';
import 'package:android_file_storage/android_file_storage_method_channel.dart';
import 'package:android_file_storage/android_file_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAndroidFileStoragePlatform
    with MockPlatformInterfaceMixin
    implements AndroidFileStoragePlatform {
  @override
  Future<String?> saveFile({
    required String fileName,
    required List<int> bytes,
    required String mimeType,
  }) {
    return Future.value("Downloaded");
  }
}

void main() {
  final AndroidFileStoragePlatform initialPlatform =
      AndroidFileStoragePlatform.instance;

  test('$MethodChannelAndroidFileStorage is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAndroidFileStorage>());
  });

  test('SaveFile', () async {
    AndroidFileStorage androidFileStoragePlugin = AndroidFileStorage();
    MockAndroidFileStoragePlatform fakePlatform =
        MockAndroidFileStoragePlatform();
    AndroidFileStoragePlatform.instance = fakePlatform;

    expect(
      await androidFileStoragePlugin.saveFile(
        fileName: "test.txt",
        bytes: [42],
        mimeType: "text/plain",
      ),
      "Downloaded",
    );
  });
}
