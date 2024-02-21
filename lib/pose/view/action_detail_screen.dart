import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:safetyedu/common/component/custom_elevated_button.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/pose/model/action_detail_model.dart';
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
  @override
  void initState() {
    super.initState();

    ref.read(poseProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(poseDetailProvider(widget.id));

    if (state == null) {
      return const DefaultLayout(
        title: '',
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is! ActionDetailModel) {
      return DefaultLayout(
        title: state.title,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    final videoId = YoutubePlayer.convertUrlToId(state.videoUrl);
    return DefaultLayout(
        title: state.title,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (videoId != null) _VideoPlayer(videoId: videoId),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: HtmlWidget(
                    state.detail,
                    textStyle: TextStyles.descriptionTextStyle,
                  ),
                ),
              ),
              CustomElevatedBotton(
                text: 'Next',
                onPressed: () {},
              )
            ],
          ),
        ));
  }
}

/// Youtube Player Widget
class _VideoPlayer extends StatefulWidget {
  final String videoId;

  const _VideoPlayer({
    required this.videoId,
  });

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  late final YoutubePlayerController _controller;

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
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        loop: true,
      ),
    )..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: hilightColor,
      progressColors: ProgressBarColors(
        playedColor: hilightColor,
        handleColor: hilightColor.withOpacity(0.8),
      ),
    );
  }
}
