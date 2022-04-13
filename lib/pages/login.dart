import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gym_routine/providers/login_provider.dart';

import 'package:gym_routine/ui/input_styles.dart';
import 'package:gym_routine/widgets/widgets.dart';

import '../utils/utils.dart';

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
            ChangeNotifierProvider(
              create: (_) => LoginFormProvider(),
              child: _LoginForm(),
            ),
            const SizedBox(
              height: 30,
            )
          ]),
        )
      ]),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginFormProvider>(
      builder: (context, values, child) => Form(
        key: values.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputStyles.authInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'e-mail',
                prefixIcon: Icons.alternate_email_sharp),
            onChanged: (value) => values.email = value,
            validator: (value) {
              RegExp regExp = RegExp(emailPattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'e-mail is not valid';
            },
          ),
          const SizedBox(height: 50),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputStyles.authInputDecoration(
                hintText: '******',
                labelText: 'Password',
                prefixIcon: Icons.lock_outline),
            onChanged: (value) => values.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'password must have at least 6 characters';
            },
          ),
          const SizedBox(height: 20),
          _LoginButton(loginProvider: values)
        ]),
      ),
    );
    // return Form(
    //   key: loginProvider.formKey,
    //   autovalidateMode: AutovalidateMode.onUserInteraction,
    //   child: Column(children: [
    //     TextFormField(
    //       autocorrect: false,
    //       keyboardType: TextInputType.emailAddress,
    //       decoration: InputStyles.authInputDecoration(
    //           hintText: 'john.doe@gmail.com',
    //           labelText: 'e-mail',
    //           prefixIcon: Icons.alternate_email_sharp),
    //       onChanged: (value) => loginProvider.email = value,
    //       validator: (value) {
    //         RegExp regExp = RegExp(emailPattern);
    //         return regExp.hasMatch(value ?? '') ? null : 'e-mail is not valid';
    //       },
    //     ),
    //     const SizedBox(height: 50),
    //     TextFormField(
    //       autocorrect: false,
    //       obscureText: true,
    //       keyboardType: TextInputType.emailAddress,
    //       decoration: InputStyles.authInputDecoration(
    //           hintText: '******',
    //           labelText: 'Password',
    //           prefixIcon: Icons.lock_outline),
    //       onChanged: (value) => loginProvider.password = value,
    //       validator: (value) {
    //         return (value != null && value.length >= 6)
    //             ? null
    //             : 'password must have at least 6 characters';
    //       },
    //     ),
    //     const SizedBox(height: 20),
    //     _LoginButton(loginProvider: loginProvider)
    //   ]),
    // );
  }
}

class _LoginButton extends StatefulWidget {
  final LoginFormProvider loginProvider;
  const _LoginButton({Key? key, required this.loginProvider}) : super(key: key);

  @override
  State<_LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton> {
  bool _registered = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          width: size.width * 0.7,
          child: SwitchListTile(
            title: const Text('Already a member?'),
            value: _registered,
            onChanged: (bool value) {
              setState(() {
                _registered = value;
              });
            },
          ),
        ),
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          minWidth: size.width * 0.33,
          disabledColor: Colors.grey,
          color: Colors.blueAccent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
            child: Text(
              _registered ? 'Login' : 'Register',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          onPressed: () {
            if (widget.loginProvider.isValidForm()) {
              if (_registered) {
                widget.loginProvider.loginUser(context);
              } else {
                widget.loginProvider.register(context);
              }
            }
          },
        ),
      ],
    );
  }
}
