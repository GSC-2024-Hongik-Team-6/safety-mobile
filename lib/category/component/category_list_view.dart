import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/category/component/category_card.dart';
import 'package:safetyedu/category/model/category_model.dart';
import 'package:safetyedu/category/provider/category_provider.dart';
import 'package:safetyedu/category/view/category_detail_screen.dart';
import 'package:safetyedu/common/model/model_list.dart';

/// [CategoryCard]의 리스트를 보여주는 ListView 위젯
class CategoryListView extends ConsumerWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryList = ref.watch(categoryListProvider);

    // 첫 로딩 시 로딩 바
    if (categoryList is ModelListLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러 발생 시
    // Error 발생
    if (categoryList is ModelListError) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            categoryList.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              ref.read(categoryListProvider.notifier).fetch(
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

    final listState = categoryList as ModelList<CategoryModel>;

    return ListView.separated(
      itemCount: listState.items.length,
      itemBuilder: (context, index) {
        final category = listState.items[index];

        return GestureDetector(
          onTap: () => context.goNamed(
            CategoryDetailScreen.routeName,
            pathParameters: {
              'cid': category.id,
            },
          ),
          child: CategoryCard(
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
