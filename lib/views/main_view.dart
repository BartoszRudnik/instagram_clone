import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Main View",
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) => TextButton(
          onPressed: () async {
            ref.read(authStateProvider.notifier).logOut();
          },
          child: const Text(
            'Logout',
          ),
        ),
      ),
    );
  }
}
