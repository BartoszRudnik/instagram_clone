import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login View',
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                await ref.read(authStateProvider.notifier).loginWithGoogle();
              },
              child: const Text(
                'Login with Google',
              ),
            ),
            TextButton(
              onPressed: () async {
                await ref.read(authStateProvider.notifier).loginWithFacebook();
              },
              child: const Text(
                'Login with Facebook',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
