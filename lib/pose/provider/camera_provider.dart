import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final camerasProvider = FutureProvider<List<CameraDescription>>((ref) async {
  return await availableCameras();
});

final cameraControllerProvider = AsyncNotifierProvider.autoDispose<
    CameraContollerNotifier, CameraController>(
  () => CameraContollerNotifier(),
);

class CameraContollerNotifier
    extends AutoDisposeAsyncNotifier<CameraController> {
  CameraController? _controller;

  Future<CameraController> _initialize() async {
    if (_controller != null) inactive();

    final cameras = await ref.read(camerasProvider.future);
    final camera = cameras.first;

    _controller = CameraController(camera, ResolutionPreset.medium);

    try {
      await _controller!.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          // Handle access errors here.
          break;
        default:
          // Handle other errors here.
          break;
      }
    }

    return _controller!;
  }

  void inactive() {
    if (_controller?.value.isInitialized ?? false) {
      _controller?.dispose();
    }
    _controller = null;
  }

  Future<void> resume() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_initialize);
  }

  @override
  FutureOr<CameraController> build() async {
    ref.onDispose(() => _controller?.dispose());
    return _initialize();
  }
}

final recordingProvider = StateNotifierProvider.family<RecordingNotifier,
    RecordingState, CameraController>(
  (ref, controller) {
    return RecordingNotifier(controller: controller);
  },
);

enum RecordingState {
  recording,
  paused,
  stop,
  loading,
}

class RecordingNotifier extends StateNotifier<RecordingState> {
  final CameraController controller;

  RecordingNotifier({
    required this.controller,
  }) : super(RecordingState.stop);

  Future<void> start() async {
    state = RecordingState.loading;
    await controller.startVideoRecording();
    state = RecordingState.recording;
  }

  Future<void> pause() async {
    state = RecordingState.loading;
    await controller.pauseVideoRecording();
    state = RecordingState.paused;
  }

  Future<void> resume() async {
    state = RecordingState.loading;
    await controller.resumeVideoRecording();
    state = RecordingState.recording;
  }

  Future<XFile> stop() async {
    state = RecordingState.loading;
    final file = await controller.stopVideoRecording();
    state = RecordingState.stop;
    return file;
  }
}
