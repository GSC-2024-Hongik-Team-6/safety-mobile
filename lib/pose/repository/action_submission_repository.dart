import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/provider/firebase_provider.dart';

final actionSubmissionRepositoryProvider = Provider<ActionSubmissionRepository>(
  (ref) {
    final functions = ref.watch(firebaseFuctionsProvider);
    final storage = ref.watch(firebaseStorageProvider);

    return ActionSubmissionRepository(
      functions: functions,
      storage: storage,
    );
  },
);

class ActionSubmissionRepository {
  final FirebaseFunctions functions;
  final FirebaseStorage storage;

  ActionSubmissionRepository({
    required this.functions,
    required this.storage,
  });

  Future<void> upload({
    required File file,
    Function(double)? onProgress,
    Function(bool)? onComplete,
    Function(String)? onError,
  }) async {
    final uploadTask = storage
        .ref()
        .child(file.path.split('/')[file.path.split('/').length - 1])
        .putFile(file);

    uploadTask.snapshotEvents.listen((event) {
      switch (event.state) {
        case TaskState.running:
          final progress = 100.0 * event.bytesTransferred / event.totalBytes;
          onProgress?.call(progress);
          onComplete?.call(false);
          break;
        case TaskState.success:
          onComplete?.call(true);
          break;
        default:
          onError?.call('Error');
          onComplete?.call(false);
          break;
      }
    });
  }

  Future<double> submit({
    required String videoUrl,
  }) async {
    final callable = functions.httpsCallable('processVideoByName');
    final httpResult = await callable.call({
      'fileName': videoUrl.split('/')[videoUrl.split('/').length - 1],
    });
    final data = httpResult.data as Map;

    final score = double.parse(data['message']);
    return score;
  }
}
