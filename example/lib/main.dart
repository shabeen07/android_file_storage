import 'dart:async';

import 'package:android_file_storage/android_file_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _androidFileStoragePlugin = AndroidFileStorage();
  final _urlController = TextEditingController(
    text: 'https://picsum.photos/200/300',
  );
  String _status = 'Idle';
  bool _isLoading = false;

  Future<void> _downloadAndSaveFile() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      setState(() => _status = 'Please enter a URL');
      return;
    }

    setState(() {
      _isLoading = true;
      _status = 'Downloading...';
    });

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() => _status = 'Saving to storage...');
        final fileName = url.split('/').last;
        final mimeType =
            response.headers['content-type'] ?? 'application/octet-stream';

        final result = await _androidFileStoragePlugin.saveFile(
          fileName: fileName,
          bytes: response.bodyBytes.toList(),
          mimeType: mimeType,
        );

        setState(() => _status = 'Saved successfully!\nURI: $result');
      } else {
        setState(
          () => _status = 'Download failed: HTTP ${response.statusCode}',
        );
      }
    } catch (e) {
      setState(() => _status = 'Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Android File Storage Example')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Download URL',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _downloadAndSaveFile,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Download and Save to Downloads'),
              ),
              const SizedBox(height: 24),
              const Text(
                'Status:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SelectableText(_status),
            ],
          ),
        ),
      ),
    );
  }
}
