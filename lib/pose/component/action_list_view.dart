import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/education/component/education_card.dart';
import 'package:safetyedu/education/model/education_model.dart';
import 'package:safetyedu/pose/provider/pose_provider.dart';
import 'package:safetyedu/pose/view/action_detail_screen.dart';

class ActionListView extends ConsumerWidget {
  const ActionListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(poseProvider);

    if (state is ModelListLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

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
              ref.read(poseProvider.notifier).fetch();
            },
            child: const Text(
              '재시도',
            ),
          ),
        ],
      );
    }

    final listState = state as ModelList<EducationModel>;

    return ListView.separated(
      itemCount: listState.data.length,
      itemBuilder: (context, index) {
        final action = listState.data[index];

        return GestureDetector(
          onTap: () => context.goNamed(
            ActionDetailScreen.routeName,
            pathParameters: {
              'id': action.id.toString(),
            },
          ),
          child: EducationCard.fromModel(action),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 16.0,
      ),
    );
  }
}
