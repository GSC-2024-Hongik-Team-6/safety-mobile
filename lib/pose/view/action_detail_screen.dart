import 'package:flutter/material.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:video_player/video_player.dart';

class ActionDetailScreen extends StatefulWidget {
  static const routeName = '/action-detail';

  final Id id;

  const ActionDetailScreen({super.key, required this.id});

  @override
  State<ActionDetailScreen> createState() => _ActionDetailScreenState();
}

class _ActionDetailScreenState extends State<ActionDetailScreen> {
  late final VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.networkUrl(
      Uri.parse(
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
    );

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize().then((_) => setState(() {}));
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const DefaultLayout(
        title: '',
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: '',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              '다음으로',
            ),
          ),
        ],
      ),
    );
  }
}
