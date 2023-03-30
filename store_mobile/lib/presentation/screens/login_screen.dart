import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mobile/domain/models/requests/login_request.dart';
import 'package:store_mobile/presentation/viewmodels/blocs/login_bloc.dart';
import 'package:store_mobile/presentation/viewmodels/events/login_event.dart';
import 'package:store_mobile/presentation/viewmodels/states/login_state.dart';
import 'package:store_mobile/utils/const/enum.dart';
import 'package:store_mobile/utils/const/variable.dart';
import 'package:store_mobile/utils/helpers/helper.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();


  void _onSubmit(BuildContext context) {
    if (_key.currentState!.validate()) {
      context.read<LoginBloc>().add(
        OnLogin(
          request: LoginRequest(
              email: _emailController.text,
              password: _passwordController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Login Page',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.isLogin) {
                    appRouter.replaceNamed('/');
                  }
                  if (state.status == Status.error && state.message != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message!)));
                  }
                },
                child: Form(
                  key: _key,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          validator: Helper.emailValidation,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: Helper.passwordValidation,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () => _onSubmit(context),
                          child: const Text('Login'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () => appRouter.pushNamed('/register'),
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
