import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes.dart';
import '../bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (_) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Welcome ${state.user.name.isEmpty ? 'User' : state.user.name}'),
                    const SizedBox(height: 8),
                    Text(state.user.email),
                  ],
                );
              }
              return const Text('You are not authenticated.');
            },
          ),
        ),
      ),
    );
  }
}
