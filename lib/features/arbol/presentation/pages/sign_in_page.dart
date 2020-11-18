import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/sign_in_form.dart';

import '../../../../injection_auto.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: BlocProvider(
          create: (context) => getIt<SignInFormBloc>(), child: SignInForm()),
    );
  }
}
