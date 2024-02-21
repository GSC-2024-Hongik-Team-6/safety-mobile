import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/common/component/custom_elevated_button.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/pose/model/action_detail_model.dart';
import 'package:safetyedu/pose/provider/pose_provider.dart';
import 'package:safetyedu/pose/view/action_submit_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final youtubePlayerProvider =
    Provider.autoDispose.family<YoutubePlayer, YoutubePlayerController>(
  (ref, controller) {
    return YoutubePlayer(
      key: ValueKey(controller),
      controller: controller,
      progressIndicatorColor: hilightColor,
      progressColors: ProgressBarColors(
        playedColor: hilightColor,
        handleColor: hilightColor.withOpacity(0.8),
      ),
    );
  },
);

final youtubePlayerControllerProvider =
    Provider.autoDispose.family<YoutubePlayerController, String>(
  (ref, videoId) {
    return YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        loop: true,
      ),
    );
  },
);

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
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(poseDetailProvider(widget.id));

    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
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

    if (videoId == null) {
      return _BottomExplain(
        id: state.id,
        title: state.title,
        detail: state.detail,
      );
    }

    final controller = ref.read(youtubePlayerControllerProvider(videoId));
    final videoPlayer = ref.read(youtubePlayerProvider(controller));

    return YoutubePlayerBuilder(
        player: videoPlayer,
        builder: (context, player) {
          return _BottomExplain(
            title: state.title,
            detail: state.detail,
            player: player,
            id: widget.id,
          );
        });
  }
}

class _BottomExplain extends StatelessWidget {
  final String title;
  final String? detail;
  final Widget? player;
  final Id id;

  const _BottomExplain({
    required this.title,
    this.detail,
    this.player,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: title,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (player != null) player!,
            const SizedBox(height: 16),
            if (detail != null)
              Expanded(
                child: SingleChildScrollView(
                  child: HtmlWidget(
                    detail!,
                    textStyle: TextStyles.descriptionTextStyle,
                  ),
                ),
              ),
            CustomElevatedBotton(
              text: 'Next',
              onPressed: () {
                context.goNamed(
                  ActionSubmitScreen.routeName,
                  pathParameters: {
                    'id': id.toString(),
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
