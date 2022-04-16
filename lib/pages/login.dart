import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_routine/providers/auth.dart';

import 'package:gym_routine/ui/input_styles.dart';
import 'package:gym_routine/widgets/widgets.dart';
import 'package:gym_routine/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBg(
            child: SingleChildScrollView(
      child: Column(children: [
        const SizedBox(
          height: 250,
        ),
        CardContainer(
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            Text('Login', style: Theme.of(context).textTheme.headline4),
            const LoginForm(),
            const SizedBox(
              height: 30,
            )
          ]),
        )
      ]),
    )));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _registered = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: [
        TextFormField(
          controller: _email,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputStyles.authInputDecoration(
              hintText: 'john.doe@gmail.com',
              labelText: 'e-mail',
              prefixIcon: Icons.alternate_email_sharp),
          validator: (value) =>
              value!.isValidEmail() ? null : 'e-mail is not valid',
        ),
        const SizedBox(height: 50),
        TextFormField(
          controller: _password,
          autocorrect: false,
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputStyles.authInputDecoration(
              hintText: '******',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline),
          validator: (value) => value!.length >= 6
              ? null
              : 'password must have at least 6 characters',
        ),
        const SizedBox(height: 20),
        Consumer(builder: ((context, ref, _) {
          final _auth = ref.watch(authenticationProvider);
          return _loading
              ? const SizedBox(
                  height: 104,
                  child: Center(child: CircularProgressIndicator()))
              : Column(
                  children: [
                    SizedBox(
                      width: size.width * 0.7,
                      child: SwitchListTile(
                        title: const Text('Already a member?'),
                        value: _registered,
                        onChanged: (bool value) =>
                            setState(() => _registered = !_registered),
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minWidth: size.width * 0.33,
                      disabledColor: Colors.grey,
                      color: Colors.blueAccent,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: size.width * 0.02),
                        child: Text(
                          _registered ? 'Login' : 'Register',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_registered) {
                            setState(() {
                              _loading = true;
                            });
                            _auth
                                .login(_email.text, _password.text, context)
                                .whenComplete(
                                    () => setState(() => _loading = false));
                          } else {
                            _auth
                                .register(_email.text, _password.text, context)
                                .whenComplete(
                                    () => setState(() => _loading = false));
                          }
                        }
                      },
                    ),
                  ],
                );
        }))
      ]),
    );
  }
}
