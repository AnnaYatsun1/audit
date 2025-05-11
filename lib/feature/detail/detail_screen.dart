import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/detail/bloc/detail/bloc/detail_bloc.dart';
import 'package:sound_level_meter/feature/detail/bloc/detail/repository/detail_repository.dart';
import 'package:sound_level_meter/feature/edite/view/edit_screen.dart';
import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';

@RoutePage()
class DetailScreen extends StatefulWidget {
  final InventoryItemView item;
  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailBloc _detailBloc;

  @override
  void initState() {
    super.initState();

    _detailBloc = DetailBloc(DetailRepository([widget.item]));
    _detailBloc.add(DetailStarted(id: widget.item.id));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBarIsVisible: true,
        child: BlocBuilder<DetailBloc, DetailState>(
            bloc: _detailBloc,
            builder: (context, state) {
              if (state is DetailInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DetailLoaded) {
                return SingleChildScrollView(
                  child: InventoryItemForm(
                        isReadonly: true, viewModel: state.detailModel, onSubmit: (model){
                          
                        }),);
              } else if (state is DetailError) {
                return Text(
                  'Error: ${state.toString() ?? "Smth happend pls try again"}');
              }
            
             return  SizedBox(
                height: 16,
              );
            
       }));
  }
}
