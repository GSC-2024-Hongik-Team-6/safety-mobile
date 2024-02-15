import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_list_meta.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/dio_provider.dart';
import 'package:safetyedu/common/repository/model_list_repository_interface.dart';
import 'package:safetyedu/pose/model/pose_model.dart';

final PoseRepositoryProvider = Provider<PoseRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return PoseRepository(dio);
  },
);

class PoseRepository implements IDetailRepository<PoseDetailModel> {
  final Dio dio;

  PoseRepository(this.dio);

  @override
  Future<ModelList<PoseDetailModel>> fetch() async {
    return Future.value(ModelList<PoseDetailModel>(
      data: [],
      meta: const ModelListMeta(count: 0),
    ));
  }

  @override
  Future<PoseDetailModel> getDetail({
    required Id id,
  }) async {
    final response = await dio.get('/Pose/$id');

    if (response.data['type'] == 'MULTIPLE_CHOICE') {
      return PoseDetailModel(
        id: id,
        type: PoseType.multipleChoice,
        data: PoseItemMultipleChoice.fromJson(
          response.data['data'],
        ),
      );
    } else {
      return PoseDetailModel(
        id: id,
        type: PoseType.order,
        data: PoseItemOrdering.fromJson(
          response.data['data'],
        ),
      );
    }
  }
}
