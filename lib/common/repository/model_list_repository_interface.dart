import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';

abstract interface class IModelListRepository<T extends IModelWithId> {
  Future<ModelList<T>> fetch();
}

abstract interface class IDetailRepository<T extends IModelWithId>
    implements IModelListRepository<T> {
  Future<T> getDetail({required Id id});
}
