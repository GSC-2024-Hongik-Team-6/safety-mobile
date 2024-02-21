import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/model_list_provider.dart';

typedef CustomListViewBuilder<T extends IModelWithId> = Widget Function(
  BuildContext context,
  int index,
  T model,
);

typedef CustomListViewSeparatorBuilder = Widget Function(
  BuildContext context,
  int index,
);

class CustomListView<T extends IModelWithId> extends ConsumerWidget {
  final StateNotifierProvider<ModelListProvider, ModelListState> provider;
  final CustomListViewBuilder<T> itemBuilder;

  /// seperate builder
  final CustomListViewSeparatorBuilder? separatorBuilder;

  const CustomListView({
    super.key,
    required this.provider,
    required this.itemBuilder,
    this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    // 첫 로딩 시 로딩 바
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
              ref.read(provider.notifier).fetch(forceRefetch: true);
            },
            child: const Text(
              '재시도',
            ),
          ),
        ],
      );
    }

    final listState = state as ModelList<T>;

    return ListView.separated(
      itemCount: listState.data.length,
      itemBuilder: (context, index) {
        final model = listState.data[index];

        return itemBuilder(context, index, model);
      },
      separatorBuilder:
          separatorBuilder ?? (_, __) => const SizedBox(height: 16.0),
    );
  }
}
