import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/pose/provider/pose_detail_provider.dart';

class PoseDetailScreen extends ConsumerStatefulWidget {
  static const routeName = '/quiz-detail';

  final Id qid;

  const PoseDetailScreen({
    super.key,
    required this.qid,
  });

  @override
  ConsumerState<PoseDetailScreen> createState() => _PoseScreenState();
}

class _PoseScreenState extends ConsumerState<PoseDetailScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(poseProvider.notifier).getDetail(id: widget.qid);
  }

  @override
  Widget build(BuildContext context) {
    final quiz = ref.watch(poseDetailProvier(widget.qid));

    if (quiz == null) {
      return const DefaultLayout(
        title: 'Loading',
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: 'Quiz Detail Page ${widget.qid}',
      child: Center(
        child: Text(
          quiz.data.description,
        ),
      ),
    );
  }
}
