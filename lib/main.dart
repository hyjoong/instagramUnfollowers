import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'firebase_service.dart';
import 'webview_service.dart';
import 'file_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await FirebaseService.initializeFirebase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const TrackFollowsPage(),
    );
  }
}

class TrackFollowsPage extends StatefulWidget {
  const TrackFollowsPage({super.key});

  @override
  State<TrackFollowsPage> createState() => _TrackFollowsPageState();
}

class _TrackFollowsPageState extends State<TrackFollowsPage> {
  late final WebViewService _webViewService;
  late final FirebaseService _firebaseService;
  late final FileHandler _fileHandler;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    _firebaseService = FirebaseService();
    _fileHandler = FileHandler();
    _webViewService = WebViewService();

    await _firebaseService.initializeMessaging();
    await _requestPermissions();
    _webViewService.initializeWebView(
      onFilePickRequested: _handleFileSelection,
      onResetComplete: _onResetComplete,
    );
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      await Permission.storage.request();
      await Permission.mediaLibrary.request();
    }
  }

  Future<void> _handleFileSelection() async {
    try {
      FilePickerResult? result = await _fileHandler.pickFile();

      if (result != null && result.files.isNotEmpty) {
        String? fileData = _fileHandler.getFileData(result);
        String? fileName = _fileHandler.getFileName(result);
        String fileType =
            _fileHandler.getFileType(result.files.first.extension);

        if (fileData != null && fileName != null) {
          // 웹뷰에 파일 설정
          bool success = await _webViewService.setFileInWebView(
              fileName, fileData, fileType);
        }
      }
    } catch (e) {
      // 파일 선택 에러 처리
    }
  }

  void _onResetComplete() {
    // 리셋 완료 시 필요한 로직
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        // 웹뷰에서 뒤로갈 수 있는지 확인
        final canGoBack = await _webViewService.canGoBack();
        if (canGoBack) {
          // 웹뷰에서 뒤로가기
          await _webViewService.goBack();
        } else {
          final shouldExit = await _showExitDialog();
          if (shouldExit && context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: WebViewWidget(
          controller: _webViewService.controller,
        ),
      ),
    );
  }

  Future<bool> _showExitDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('앱 종료'),
            content: const Text('앱을 종료하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('종료'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
