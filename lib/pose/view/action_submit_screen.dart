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
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();

    ref.read(poseProvider.notifier).getDetail(id: widget.id);
  }

  Future<void> startVideoRecording({
    required CameraController controller,
    String? videoPath,
  }) async {
    if (controller.value.isRecordingVideo) {
      // A recording is already started
      return;
    }
    try {
      setState(() {
        _isRecording = true;
      });
      await controller.startVideoRecording();
    } on CameraException catch (e) {
      print(e);
    }
  }

  Future<void> stopVideoRecording({
    required CameraController controller,
  }) async {
    if (!controller.value.isRecordingVideo) {
      return;
    }
    try {
      setState(() {
        _isRecording = false;
      });
      await controller.stopVideoRecording();
    } on CameraException catch (e) {
      print(e);
    }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedBotton(
                      text: _isRecording ? 'Stop' : 'Record',
                      onPressed: () async {
                        if (!mounted) return;

                        if (_isRecording) {
                          await stopVideoRecording(controller: controller);
                        } else {
                          await startVideoRecording(controller: controller);
                        }
                      },
                      backgroundColor: _isRecording ? Colors.red : null,
                    ),
                    CustomElevatedBotton(
                      text: 'Submit',
                      onPressed: () {},
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
