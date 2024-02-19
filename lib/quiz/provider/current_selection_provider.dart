import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/model/current_selection.dart';

/// 현재 사용자의 선택 상태를 관리하는 Provider (퀴즈 단일)
final currentSelectionProvider =
    Provider.family<CurrentSelection?, Id>((ref, id) {
  final state = ref.watch(selectionProvider);

  return state.firstWhereOrNull((e) => e.quizId == id);
});

final selectionProvider = StateNotifierProvider<CurrentSelectionStateNotifier,
    List<CurrentSelection>>(
  (ref) => CurrentSelectionStateNotifier(),
);

/// 유저의 선택 상태를 관리하는 StateNotifier
class CurrentSelectionStateNotifier
    extends StateNotifier<List<CurrentSelection>> {
  CurrentSelectionStateNotifier() : super([]);

  /// _주의: select는 유저의 option 선택 함수지, db select와 관계 없음_
  void select({
    required Id quizId,
    required int number,
  }) {
    final target = state.firstWhereOrNull((e) => e.quizId == quizId);

    if (target == null) {
      // 아직 선택된 것이 없을 경우, 새 선택을 추가
      state = [
        ...state,
        CurrentSelection(
          quizId: quizId,
          number: number,
        ),
      ];

      return;
    }

    if (target.number == number) {
      // 이미 선택된 것을 다시 선택할 경우, 선택 해제
      state = state.where((e) => e.quizId != quizId).toList();
      return;
    }

    // 선택된 것을 변경할 경우, 선택 변경
    state = state
        .map((e) => e.quizId == quizId ? e.copyWith(number: number) : e)
        .toList();
  }

  void unselect({
    required Id quizId,
  }) {
    state = state.where((e) => e.quizId != quizId).toList();
  }
}
