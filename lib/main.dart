import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_routine/widgets/auth_check.dart';
import 'package:gym_routine/pages/pages.dart';

import 'package:gym_routine/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

final firebaseInitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseInitializerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Routine App',
      onGenerateRoute: Routers.generateRoute,
      home: initialize.when(data: (data) {
        return const AuthChecker();
      }, error: (e, stackTrace) {
        return const ErrorScreen();
      }, loading: () {
        return const LoadingScreen();
      }),
      theme:
          ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey[300]),
    );
  }
}
