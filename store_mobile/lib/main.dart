import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store_mobile/config/theme/theme.dart';
import 'package:store_mobile/domain/repositories/remote/remotre_repository.dart';
import 'package:store_mobile/locator.dart';
import 'package:store_mobile/presentation/viewmodels/blocs/checkout_bloc.dart';
import 'package:store_mobile/presentation/viewmodels/blocs/home_bloc.dart';
import 'package:store_mobile/presentation/viewmodels/blocs/login_bloc.dart';
import 'package:store_mobile/presentation/viewmodels/blocs/product_bloc.dart';
import 'package:store_mobile/presentation/viewmodels/blocs/register_bloc.dart';
import 'package:store_mobile/utils/const/string.dart';
import 'package:store_mobile/utils/const/variable.dart';

void main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LoginBloc(
                repository: locator<RemoteRepository>(),
                storage: locator<FlutterSecureStorage>())),
        BlocProvider(
          create: (context) =>
              HomeBloc(repository: locator<RemoteRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              ProductBloc(repository: locator<RemoteRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              CheckoutBloc(repository: locator<RemoteRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              RegisterBloc(repository: locator<RemoteRepository>()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: APP_NAME,
        theme: theme,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
