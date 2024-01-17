import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/common/view/root_tab.dart';
import 'package:safetyedu/common/view/splash_screen.dart';
import 'package:safetyedu/user/provider/auth_provider.dart';
import 'package:safetyedu/user/view/login_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.read(authProvider);
  return GoRouter(
    routes: _routes,
    initialLocation: '/splash',
    refreshListenable: provider,
    redirect: provider.redirectLogic,
    debugLogDiagnostics: true,
  );
});

List<GoRoute> _routes = [
  GoRoute(
    path: '/',
    name: TabView.routeName,
    builder: (_, __) => const TabView(),
  ),
  GoRoute(
    path: '/splash',
    name: SplashPage.routeName,
    builder: (_, __) => const SplashPage(),
  ),
  GoRoute(
    path: '/login',
    name: LoginScreen.routeName,
    builder: (_, __) => const LoginScreen(),
  ),
];