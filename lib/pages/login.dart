import 'package:flutter/material.dart';
import 'package:gym_routine/ui.dart/input_styles.dart';
import 'package:gym_routine/widgets/widgets.dart';

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
            _LoginForm(),
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
    return Form(
      child: Column(children: [
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputStyles.authInputDecoration(
              hintText: 'john.doe@gmail.com',
              labelText: 'email',
              prefixIcon: Icons.alternate_email_sharp),
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
        ),
        const SizedBox(height: 20),
        const _LoginButton()
      ]),
    );
  }
}

class _LoginButton extends StatefulWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  State<_LoginButton> createState() => __LoginButtonState();
}

class __LoginButtonState extends State<_LoginButton> {
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
          onPressed: () {},
        ),
      ],
    );
  }
}
