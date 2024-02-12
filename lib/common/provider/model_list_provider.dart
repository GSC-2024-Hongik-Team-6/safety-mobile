import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/repository/model_list_repository_interface.dart';

class ModelListProvider<Model extends IModelWithId,
        Repository extends IModelListRepository<Model>>
    extends StateNotifier<ModelListState> {
  final Repository repository;

  ModelListProvider({
    required this.repository,
  }) : super(ModelListLoading());

  Future<void> fetch() async {
    try {
      final modelList = await repository.fetch();

      state = modelList;
    } catch (e) {
      state = ModelListError(message: e.toString());
    }
  }
}

class DetailProvider<Model extends IModelWithId,
        Repository extends IDetailRepository<Model>>
    extends ModelListProvider<Model, Repository> {
  DetailProvider({
    required super.repository,
  });

  Future<void> getDetail({
    required Id id,
  }) async {
    // 만약 데이터가 없다면 fetch()를 호출
    if (state is! ModelList) {
      await fetch();
    }

    // 그럼에도 데이터가 없다면 return
    if (state is! ModelList) {
      return;
    }

    final modelList = state as ModelList<Model>;

    final response = await repository.getDetail(id: id);

    if (modelList.items.where((element) => element.id == id).isEmpty) {
      modelList.items.add(response);
    }

    state = modelList.copyWith(
      items: modelList.items.map((e) => e.id == id ? response : e).toList(),
    );
  }
}
