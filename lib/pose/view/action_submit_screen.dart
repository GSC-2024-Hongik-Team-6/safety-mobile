import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/component/custom_elevated_button.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/view/error_screen.dart';
import 'package:safetyedu/pose/provider/camera_provider.dart';
import 'package:safetyedu/pose/provider/pose_provider.dart';

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
                  style: TextStyles.descriptionTextStyle,
                ),
                AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: CameraPreview(controller),
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
                          : () {
                              print('Submit video: ${_videoFile!.path}');
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
