import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/pages/details_page.dart';
import 'package:travel_app/pages/main_page.dart';

import 'app_cubit_states.dart';
import 'app_cubits.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({Key? key}) : super(key: key);

  @override
  _AppCubitLogicsState createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          // Loading State
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Loaded State
          else if (state is LoadedState) {
            return const MainPage();
          }

          // Detail State
          else if (state is DetailState) {
            return const DetailsPage();

            // Error
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
