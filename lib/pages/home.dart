import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_routine/providers/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      final _auth = ref.watch(authenticationProvider);
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Home"),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  color: Colors.blueAccent,
                  child: const Text(
                    'sign Out',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: (() => _auth.signOut())),
            ],
          ),
        ),
      );
    }));
  }
}
