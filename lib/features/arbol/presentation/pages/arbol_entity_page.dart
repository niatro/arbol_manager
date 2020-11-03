import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/presentation/bloc/arboles_entity/arboles_entity_bloc.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/project_widgets.dart';
import 'package:flutterapparbol/injection_container.dart';

class ArbolesEntityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arboles'),
      ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  BlocProvider<ArbolesEntityBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<ArbolesEntityBloc>(),
      child: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 10.0),
                BlocBuilder<ArbolesEntityBloc, ArbolesEntityState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return MessageDisplay(message: 'Start Searching !');
                    } else if (state is Loading) {
                      return LoadingWidget();
                    } else if (state is LoadedArboles) {
                      return ArbolesDisplay(arbolesEntity: state.arboles);
                    } else if (state is Error) {
                      return MessageDisplay(message: state.message);
                    } else {
                      return null;
                    }
                  },
                ),
                // Top Half
                SizedBox(height: 20.0),
                // Bottom Half
                ArbolesControles()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
