import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:gym_routine/pages/pages.dart';
import 'package:gym_routine/providers/auth.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    return _authState.when(
        data: (data) {
          if (data != null) return const HomeScreen();
          return const LoginScreen();
        },
        loading: () => const LoadingScreen(),
        error: (e, trace) => const ErrorScreen());
  }
}
