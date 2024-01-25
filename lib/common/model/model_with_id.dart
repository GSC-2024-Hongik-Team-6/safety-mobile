typedef Id = int;

/// id를 가지는 모델의 추상 클래스
abstract interface class ModelWithId<T extends Id> {
  final T id;

  const ModelWithId({
    required this.id,
  });
}
