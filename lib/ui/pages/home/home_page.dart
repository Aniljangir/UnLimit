import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unlimit_demo/bloc/base_state.dart';
import 'package:unlimit_demo/bloc/jokes/jokes_cubit.dart';
import 'package:unlimit_demo/bloc/jokes/jokes_state.dart';
import 'package:unlimit_demo/res/strings/strings.dart';
import 'package:unlimit_demo/ui/pages/home/jokes_item.dart';
import 'package:unlimit_demo/ui/utils/extensions/context_extension.dart';
import 'package:unlimit_demo/ui/utils/extensions/pop_up_extension.dart';
import 'package:unlimit_demo/ui/widget/app_safe_area.dart';
import 'package:unlimit_demo/ui/widget/app_screen_widget.dart';
import 'package:unlimit_demo/ui/widget/app_text.dart';
import 'package:unlimit_demo/ui/widget/error_msg.dart';

class HomePage extends AppScreenWidget {
  const HomePage({super.key});

  @override
  Widget buildView(BuildContext context) {
    final cubit = BlocProvider.of<JokesCubit>(context);
    final jokesColors = cubit.jokeColorList;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: AppText(
          Strings.homeTitle,
          textStyle: context.appBarTitleStyle,
        ),
      ),
      body: AppSafeArea(
          bottomPadding: 0,
          topPadding: 0,
          leftPadding: 0,
          rightPadding: 0,
          child:
              BlocConsumer<JokesCubit, BaseState>(listener: (context, state) {
            if (state is JokesState && state.jokes.isEmpty) {
              context.showSnackBar('no jokes found');
            } else if (state is ErrorState) {
              context.showSnackBar(state.msg);
              cubit.isFetching = false;
            }
            return;
          }, builder: (context, state) {
            if (state is InitialState || state is LoadingState) {
              return const Center(
                  child: CupertinoActivityIndicator(
                radius: 20,
              ));
            } else if (state is ErrorState) {
              return ErrorMessageWidget(msg: state.msg);
            } else if (state is JokesState) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: state.jokes.length,
                itemBuilder: (context, index) {
                  final currentColor = jokesColors[index % jokesColors.length];
                  final nextColor = index == state.jokes.length - 1
                      ? Colors.white
                      : jokesColors[(index + 1) % jokesColors.length];

                  return JokesItem(
                    joke: state.jokes[index],
                    currentColor: currentColor,
                    nextColor: nextColor,
                  );
                },
              );
            }
            return Container();
          })),
    );
  }
}
