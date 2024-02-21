import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/pose/provider/pose_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ActionDetailScreen extends ConsumerStatefulWidget {
  static const routeName = '/action-detail';

  final Id id;

  const ActionDetailScreen({super.key, required this.id});

  @override
  ConsumerState<ActionDetailScreen> createState() => _ActionDetailScreenState();
}

class _ActionDetailScreenState extends ConsumerState<ActionDetailScreen> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(
      'https://www.youtube.com/watch?v=q7J2T6MFA9g&t=84s',
    );

    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        loop: true,
        startAt: 84,
      ),
    )..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: hilightColor,
        progressColors: ProgressBarColors(
          playedColor: hilightColor,
          handleColor: hilightColor.withOpacity(0.8),
        ),
      ),
      builder: (context, player) => DefaultLayout(
        title: 'CPR',
        child: Column(
          children: [
            player,
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
