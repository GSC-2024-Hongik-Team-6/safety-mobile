import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/common/component/custom_elevated_button.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/view/error_screen.dart';
import 'package:safetyedu/pose/provider/action_submit_provider.dart';

class ActionScoreScreen extends ConsumerWidget {
  static const routeName = '/action-score';

  final Id id; // action id

  const ActionScoreScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(actionScoreProvider(id));

    if (state == null) {
      return const ErrorScreen(
        message: 'Cannot load find action submission',
      );
    }
    return DefaultLayout(
      title: 'Score',
      child: state.when(
        uploading: (id, progress) => _UploadingBody(progress: progress),
        submitted: (id, score) => _ScoreBody(score: score),
        error: (id, message) => ErrorScreen(message: message),
        uploaded: (id) => const _WaitingResultBody(),
      ),
    );
  }
}

class _ScoreBody extends StatelessWidget {
  final double score;
  const _ScoreBody({
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final score = (this.score * 100).toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Accuracy', style: TextStyles.titleTextStyle),
                Text(
                  '$score%',
                  style: TextStyles.titleTextStyle.copyWith(
                    fontSize: 48,
                    color: hilightColor,
                  ),
                ),
              ],
            ),
          ),
          CustomElevatedBotton(
            text: 'Back To Detail',
            onPressed: () {
              context.pop();
            },
          )
        ],
      ),
    );
  }
}

class _WaitingResultBody extends StatelessWidget {
  const _WaitingResultBody();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Uploaded, waiting for results...',
        style: TextStyles.descriptionTextStyle,
      ),
    );
  }
}

class _UploadingBody extends StatelessWidget {
  final double progress;

  const _UploadingBody({
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'File Uploading... $progress%',
        style: TextStyles.descriptionTextStyle,
      ),
    );
  }
}
