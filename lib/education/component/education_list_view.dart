import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/education/component/education_card.dart';
import 'package:safetyedu/education/model/education_model.dart';
import 'package:safetyedu/education/provider/education_provider.dart';
import 'package:safetyedu/education/view/education_detail_screen.dart';
import 'package:safetyedu/common/model/model_list.dart';

/// [EducationCard]의 리스트를 보여주는 ListView 위젯
class EducationListView extends ConsumerWidget {
  const EducationListView({super.key});

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

    return ListView.separated(
      itemCount: listState.data.length,
      itemBuilder: (context, index) {
        final category = listState.data[index];

        return GestureDetector(
          onTap: () => context.goNamed(
            EducationDetailScreen.routeName,
            pathParameters: {
              'cid': category.id.toString(),
            },
          ),
          child: EducationCard(
            title: category.title,
            description: category.description,

            /// TODO: Implement Image showing
            image: const Icon(Icons.warning),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(
        height: 16.0,
      ),
    );
  }
}
