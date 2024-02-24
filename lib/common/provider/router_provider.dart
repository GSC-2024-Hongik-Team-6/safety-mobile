import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/view/error_screen.dart';
import 'package:safetyedu/education/view/education_detail_screen.dart';
import 'package:safetyedu/common/view/root_tab.dart';
import 'package:safetyedu/common/view/splash_screen.dart';
import 'package:safetyedu/pose/view/action_detail_screen.dart';
import 'package:safetyedu/pose/view/action_score_screen.dart';
import 'package:safetyedu/pose/view/action_submit_screen.dart';
import 'package:safetyedu/quiz/view/quiz_detail_screen.dart';
import 'package:safetyedu/user/provider/auth_provider.dart';
import 'package:safetyedu/user/view/login_screen.dart';
import 'package:safetyedu/user/view/signup_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.read(authProvider);
  return GoRouter(
    routes: _routes,
    initialLocation: '/splash',
    refreshListenable: provider,
    redirect: provider.redirectLogic,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) =>
        ErrorScreen(message: state.error.toString()),
  );
});

List<GoRoute> _routes = [
  GoRoute(
    path: '/',
    name: TabView.routeName,
    builder: (_, __) => const TabView(),
    routes: [
      GoRoute(
          path: 'education/:eid',
          name: EducationDetailScreen.routeName,
          builder: (_, state) => EducationDetailScreen(
                eid: state.pathParameters['eid']!.toId(),
              ),
          routes: [
            // /education/:eid/quiz/:qid
            GoRoute(
              path: 'quiz/:qid',
              name: QuizDetailScreen.routeName,
              builder: (_, state) => QuizDetailScreen(
                qid: state.pathParameters['qid']!.toId(),
              ),
            ),
          ])
    ],
  ),
  GoRoute(
    path: '/action/:id',
    name: ActionDetailScreen.routeName,
    builder: (_, state) => ActionDetailScreen(
      id: state.pathParameters['id']!.toId(),
    ),
    routes: [
      // /action/:id/submit
      GoRoute(
        path: 'submit',
        name: ActionSubmitScreen.routeName,
        builder: (_, state) => ActionSubmitScreen(
          id: state.pathParameters['id']!.toId(),
        ),
      ),
      GoRoute(
        path: 'score',
        name: ActionScoreScreen.routeName,
        builder: (context, state) => ActionScoreScreen(
          id: state.pathParameters['id']!.toId(),
        ),
      )
    ],
  ),
  GoRoute(
    path: '/splash',
    name: SplashScreen.routeName,
    builder: (_, __) => const SplashScreen(),
  ),
  GoRoute(
    path: '/login',
    name: LoginScreen.routeName,
    builder: (_, __) => const LoginScreen(),
  ),
  GoRoute(
    path: '/sign-up',
    name: SignUpScreen.routeName,
    builder: (_, __) => const SignUpScreen(),
  ),
];
