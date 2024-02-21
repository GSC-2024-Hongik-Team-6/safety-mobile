import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:video_player/video_player.dart';

class ActionDetailScreen extends ConsumerWidget {
  static const routeName = '/action-detail';

  final Id id;

  const ActionDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late VideoPlayerController controller;
    double? aspectRatio;
    controller = VideoPlayerController.networkUrl(
        Uri.parse("https://www.youtube.com/watch?v=q7J2T6MFA9g&t=84s"))
      ..initialize();
    controller.setPlaybackSpeed(1);
    controller.play();
    aspectRatio = controller.value.aspectRatio;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(aspectRatio: aspectRatio, child: VideoPlayer(controller)),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {},
          child: const Text(
            '다음으로',
          ),
        ),
      ],
    );
  }
}
