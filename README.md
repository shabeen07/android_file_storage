# android_file_storage

Save files (PDFs, Images, Text, Binary) directly to the Android `Downloads` directory using the native **MediaStore API**.

## Features
* No `WRITE_EXTERNAL_STORAGE` permission required on Android 10+ (API 29+).
* Native MediaStore integration with `IS_PENDING` flag support.
* Compatible with AGP 9.0+ and modern built-in Kotlin integration.

## Usage

```dart
import 'package:android_file_storage/android_file_storage.dart';

final storage = AndroidFileStorage();

void saveDoc() async {
  final bytes = [/* Your file bytes */];
  final String? path = await storage.saveFile(
    fileName: "document.pdf",
    bytes: bytes,
    mimeType: "application/pdf",
  );
}