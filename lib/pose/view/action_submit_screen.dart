import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/component/custom_elevated_button.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/view/error_screen.dart';
import 'package:safetyedu/pose/provider/camera_provider.dart';
import 'package:safetyedu/pose/provider/pose_provider.dart';
import 'package:safetyedu/pose/repository/action_submission_repository.dart';

class ActionSubmitScreen extends ConsumerStatefulWidget {
  static const routeName = '/action-submit';

  final Id id;

  const ActionSubmitScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ActionSubmitScreen> createState() => _ActionSubmitScreenState();
}

class _ActionSubmitScreenState extends ConsumerState<ActionSubmitScreen> {
  XFile? _videoFile;

  @override
  void initState() {
    super.initState();

    ref.read(poseProvider.notifier).getDetail(id: widget.id);
  }

  Future<void> startVideoRecording({
    required CameraController controller,
    String? videoPath,
  }) async {
    await ref.read(recordingProvider(controller).notifier).start();
  }

  Future<void> stopVideoRecording({
    required CameraController controller,
  }) async {
    final file = await ref.read(recordingProvider(controller).notifier).stop();
    setState(() {
      _videoFile = file;
    });
  }

  Future<Map> submitVideo() async {
    if (_videoFile == null) return {};

    final file = File(_videoFile!.path);

    await ref.read(actionSubmissionRepositoryProvider).upload(file: file);
    final result = await ref
        .read(actionSubmissionRepositoryProvider)
        .submit(videoUrl: file.path);

    return result.data;
  }

  @override
  Widget build(BuildContext context) {
    final cameraController = ref.watch(cameraControllerProvider);
    final actionDetail = ref.watch(poseDetailProvider(widget.id));

    if (actionDetail == null) {
      return const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return cameraController.when(
      data: (controller) {
        if (!controller.value.isInitialized) {
          return const DefaultLayout(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final recordingState = ref.watch(recordingProvider(controller));

        return DefaultLayout(
          title: actionDetail.title,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Record your action for ${actionDetail.title}',
                  style: TextStyles.subTitleTextStyle,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CameraPreview(controller),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedBotton(
                      text: recordingState == RecordingState.recording
                          ? 'Stop'
                          : 'Record',
                      onPressed: recordingState == RecordingState.loading
                          ? null
                          : () async {
                              if (!mounted) return;

                              if (recordingState == RecordingState.recording) {
                                await stopVideoRecording(
                                    controller: controller);
                              } else {
                                await startVideoRecording(
                                    controller: controller);
                              }
                            },
                      backgroundColor:
                          recordingState == RecordingState.recording
                              ? Colors.red
                              : null,
                    ),
                    CustomElevatedBotton(
                      text: 'Submit',
                      onPressed: _videoFile == null
                          ? null
                          : () async {
                              // Show loading dialog
                              showDialog(
                                context: context,
                                barrierDismissible:
                                    false, // Prevents closing the dialog by tapping outside.
                                builder: (BuildContext context) {
                                  return const Dialog(
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircularProgressIndicator(),
                                          SizedBox(width: 20),
                                          Text("Submitting..."),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );

                              try {
                                var result = await submitVideo();
                                Navigator.of(context)
                                    .pop(); // Close the loading dialog
                                // Show result dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Submission Result'),
                                      content: Text(result[
                                          'message']), // Assuming submitVideo returns a String message
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } catch (e) {
                                Navigator.of(context)
                                    .pop(); // Ensure loading dialog is closed on error
                                // Handle error, maybe show an error dialog
                              }
                            },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => ErrorScreen(message: error.toString()),
      loading: () => const DefaultLayout(
          child: Center(
        child: CircularProgressIndicator(),
      )),
    );
  }
}
