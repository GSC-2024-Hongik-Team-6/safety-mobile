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
      storege: storage,
    );
  },
);

class ActionSubmissionRepository {
  final FirebaseFunctions functions;
  final FirebaseStorage storege;

  ActionSubmissionRepository({
    required this.functions,
    required this.storege,
  });

  Future<void> upload({
    required File file,
  }) async {
    final ref = storege.ref('videos').child(file.path);

    try {
      await ref.putFile(file);
    } catch (e) {
      rethrow;
    }
  }

  Future<HttpsCallableResult> submit({
    required String videoUrl,
  }) async {
    try {
      final callable = functions.httpsCallable('submitAction');
      return await callable.call({
        'fileName': videoUrl,
      });
    } catch (e) {
      rethrow;
    }
  }
}
