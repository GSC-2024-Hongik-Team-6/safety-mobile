import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';

void action_doing_view() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Video Recorder',
      home: CameraPage(),
    );
  }
}

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  String? videoPath;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      print('Signed in anonymously');
    } catch (e) {
      print(e); // Handle error
    }
  }

  Future<void> processVideoOnCall(fileName) async {

    print("uploading...");

    if (FirebaseAuth.instance.currentUser == null) {
      await signInAnonymously(); // Or your preferred sign-in method
    }

    final HttpsCallableResult results = await FirebaseFunctions
        .instance
        .httpsCallable("processVideoByName")
        .call(<String, dynamic>{'fileName': fileName});

    print("uploading done");

    // String message = results.data;
    print(results.data); // This will print: "Hello, [name]!"
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras![0], ResolutionPreset.medium);
    await controller!.initialize();
    setState(() {});
  }

  Future<void> startVideoRecording() async {
    print("start recording");
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String videoDirectory = '${appDirectory.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = join(videoDirectory, '$currentTime.mp4');

    try {
      await controller!.startVideoRecording();
      videoPath = filePath;
    } catch (e) {
      print(e);
    }
  }

  Future<void> stopVideoRecording() async {
    print("stop recording");
    if (controller!.value.isRecordingVideo) {
      await controller!.stopVideoRecording().then((file) {
        file.saveTo(videoPath!);
        uploadVideo(videoPath!);
      });
    }
  }

  Future<void> uploadVideo(String filePath) async {
    File videoFile = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('/${basename(filePath)}') // basename used here
          .putFile(videoFile);
      // Success handling
    } on firebase_storage.FirebaseException catch (e) {
      // Error handling
      print(e);
    } finally {
      print(filePath.split('/')[filePath.split('/').length-1]);
      processVideoOnCall(filePath.split('/')[filePath.split('/').length-1]);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Video'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: CameraPreview(controller!),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  if (!controller!.value.isRecordingVideo) {
                    startVideoRecording();
                  } else {
                    stopVideoRecording();
                  }
                },
                child: Icon(
                  controller!.value.isRecordingVideo ? Icons.stop : Icons.videocam,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
