import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/education/component/education_card.dart';
import 'package:safetyedu/education/model/education_model.dart';
import 'package:safetyedu/education/provider/education_provider.dart';
import 'package:safetyedu/education/view/education_detail_screen.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:video_player/video_player.dart';

/// [ActionView]의 리스트를 보여주는 ListView 위젯
class ActionDetailView extends ConsumerWidget {
  const ActionDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(educationProvider);

    // 첫 로딩 시 로딩 바
    if (state is ModelListLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러 발생 시
    // Error 발생
    if (state is ModelListError) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              ref.read(educationProvider.notifier).fetch(
                // forceRefetch: true, TODO: force Refetch 구현 필요
              );
            },
            child: const Text(
              '재시도',
            ),
          ),
        ],
      );
    }

    final listState = state as ModelList<EducationModel>;
    
    late VideoPlayerController controller;
    double? aspectRatio;
    controller = VideoPlayerController.networkUrl(Uri.parse("https://www.youtube.com/watch?v=q7J2T6MFA9g&t=84s"))
      ..initialize();
    controller.setPlaybackSpeed(1);
    controller.play();
    aspectRatio = controller.value.aspectRatio;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
            aspectRatio: aspectRatio!, child: VideoPlayer(controller)),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {

          },
          child: const Text(
            '다음으로',
          ),
        ),
      ],
    );
  }
}
