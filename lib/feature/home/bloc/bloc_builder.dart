

import 'package:flutter/material.dart';

import 'home_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/home/bloc/home_bloc.dart';

// BlocBuilder<HomeBloc, HomeState>(
//   bloc: _homeBloc,
//   builder: (context, state) {
//     if (state is HomeInitial) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (state is HomeLoading) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (state is HomeLoaded) {
//       return Text('Loaded ${state.techniqueList.length} items!');
//     } else if (state is HomeError) {
//       return Text('Error: ${state.message}'); // <-- тут без \ перед $
//     }
//     return const SizedBox.shrink();
//   },
// )
