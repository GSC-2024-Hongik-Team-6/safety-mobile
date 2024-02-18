typedef Id = int;

extension IdExtension on String {
  Id toId() => int.parse(this);
}

/// id를 가지는 모델의 추상 클래스
abstract interface class IModelWithId<T extends Id> {
  final T id;

  const IModelWithId({
    required this.id,
  });
}
