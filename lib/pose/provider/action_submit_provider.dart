import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/pose/model/user_action_score_model.dart';
import 'package:safetyedu/pose/repository/action_submission_repository.dart';

final actionScoreProvider = Provider.family<ActionScoreState?, Id>(
  (ref, actionId) {
    final state = ref.watch(actionSubmitProvider);

    final result = state.firstWhereOrNull((element) => element.id == actionId);

    return result;
  },
);

final actionSubmitProvider =
    StateNotifierProvider<ActionSubmitStateNotifier, List<ActionScoreState>>(
  (ref) {
    final repository = ref.watch(actionSubmissionRepositoryProvider);

    return ActionSubmitStateNotifier(
      repository: repository,
    );
  },
);

class ActionSubmitStateNotifier extends StateNotifier<List<ActionScoreState>> {
  final ActionSubmissionRepository repository;

  ActionSubmitStateNotifier({
    required this.repository,
  }) : super([]);

  Future<void> uploadAndSubmit({
    required Id actionId,
    required File file,
    required String videoUrl,
  }) async {
    await upload(
      actionId: actionId,
      file: file,
    );

    await submit(
      actionId: actionId,
      videoUrl: videoUrl,
    );
  }

  Future<void> submit({
    required Id actionId,
    required String videoUrl,
  }) async {
    try {
      final response = await repository.submit(
        videoUrl: videoUrl,
      );

      state = state.map(
        (e) {
          if (e.id == actionId) {
            return ActionScoreState.submitted(
              id: e.id,
              score: response,
            );
          }
          return e;
        },
      ).toList();
    } catch (error, stacktrace) {
      state = state.map(
        (e) {
          if (e.id == actionId) {
            return ActionScoreState.error(
              id: e.id,
              message:
                  'Submit Failed : ${error.toString()}\n${stacktrace.toString()}',
            );
          }
          return e;
        },
      ).toList();

      return;
    }
  }

  Future<void> upload({
    required Id actionId,
    required File file,
  }) async {
    final actionModel = _getState(actionId);

    if (actionModel == null) {
      // 새로운 ActionScoreState 생성 및 추가
      state = [
        ...state,
        ActionScoreState.uploading(
          id: actionId,
          progress: 0,
        )
      ];
    }
    await repository.upload(
      file: file,
      onProgress: (progress) {
        state = state.map((e) {
          if (e.id == actionId) {
            return ActionScoreState.uploading(
              id: e.id,
              progress: progress,
            );
          }
          return e;
        }).toList();
      },
      onComplete: (isCompleted) {
        if (isCompleted) {
          state = state.map((e) {
            if (e.id == actionId) {
              return ActionScoreState.uploaded(id: e.id);
            }
            return e;
          }).toList();
        }
      },
      onError: (message) {
        state = state.map((e) {
          if (e.id == actionId) {
            return ActionScoreState.error(
              id: e.id,
              message: message,
            );
          }
          return e;
        }).toList();
      },
    );
  }

  ActionScoreState? _getState(Id actionId) {
    return state.firstWhereOrNull((element) => element.id == actionId);
  }
}
