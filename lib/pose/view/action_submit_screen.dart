import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

        _isRecording = controller.value.isRecordingVideo;

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
                CameraPreview(controller),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedBotton(
                      text: _isRecording ? 'Stop' : 'Record',
                      onPressed: () {
                        if (_isRecording) {
                          controller.stopVideoRecording();
                          setState(() {
                            _isRecording = false;
                          });
                        } else {
                          controller.startVideoRecording();
                          setState(() {
                            _isRecording = true;
                          });
                        }
                      },
                      backgroundColor: _isRecording ? Colors.red : null,
                    ),
                    CustomElevatedBotton(
                      text: 'Submit',
                      onPressed: () {},
                    ),
                  ],
                )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     FloatingActionButton(
                //       onPressed: () {
                //         if (!controller.value.isRecordingVideo) {
                //           startVideoRecording();
                //         } else {
                //           stopVideoRecording();
                //         }
                //       },
                //       child: Icon(
                //         controller.value.isRecordingVideo
                //             ? Icons.stop
                //             : Icons.videocam,
                //       ),
                //     )
                //   ],
                // )
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
