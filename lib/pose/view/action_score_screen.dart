import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
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
      const DefaultLayout(
        child: Center(
          child: Text('Submitting...'),
        ),
      )
    }
  }
}
