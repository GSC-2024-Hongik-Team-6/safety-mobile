import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final envProvider = Provider<Environments>((ref) {
  return Environments(
    dotEnv: ref.watch(_dotEnvProvider),
  );
});

final _dotEnvProvider = Provider<DotEnv>(
  (ref) {
    return dotenv;
  },
);

class Environments {
  final DotEnv dotEnv;
  Environments({
    required this.dotEnv,
  });

  String get apiUrl => dotEnv.get('API_URL');
}
