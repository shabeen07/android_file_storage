import 'package:android_file_storage/android_file_storage_method_channel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelAndroidFileStorage platform = MethodChannelAndroidFileStorage();
  const MethodChannel channel = MethodChannel('android_file_storage');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return 'Downloaded';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('SaveFile', () async {
    expect(
      await platform.saveFile(
        fileName: "test.txt",
        bytes: [42],
        mimeType: "text/plain",
        subFolder: "test",
      ),
      'Downloaded',
    );
  });
}
