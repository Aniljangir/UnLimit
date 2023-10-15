import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unlimit_demo/bloc/jokes/jokes_cubit.dart';
import 'package:unlimit_demo/configs/logging_utils.dart';
import 'package:unlimit_demo/data/local/app_storage_impl.dart';
import 'package:unlimit_demo/repository/jokes/jokes_repository.dart';
import 'package:unlimit_demo/ui/pages/home/home_page.dart';
import 'package:unlimit_demo/ui/widget/app_text.dart';

class AppRoutes {
  static const home = '/';

  static Route<dynamic>? generateRoute(RouteSettings setting) {
    final args = setting.arguments;
    Logging().logger.e("route is ${setting.name}");
    switch (setting.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<JokesCubit>(
                  create: (context) => JokesCubit(
                      jokesRepository: JokesRepository(),
                      localStorage: AppStorageImpl()),
                  child: const HomePage(),
                ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const AppText('Error'),
            centerTitle: true,
          ),
          body: const Center(
            child: AppText('Page not found!'),
          ),
        );
      },
    );
  }
}
