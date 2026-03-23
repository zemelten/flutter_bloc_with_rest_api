import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/authentication/presentation/bloc/auth_bloc.dart';
import '../injection/injection_container.dart';

final List<BlocProvider> blocProviders = [
  BlocProvider<AuthBloc>(
    create: (_) => sl<AuthBloc>()..add(AuthStarted()),
  ),
];
