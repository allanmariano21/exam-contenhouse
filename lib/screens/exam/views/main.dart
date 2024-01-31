import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_exam/core/app/view.dart' as base;
import 'package:mobile_exam/core/services/server.dart';
import 'package:mobile_exam/models/data_model.dart';
import 'package:mobile_exam/screens/exam/data_bloc.dart';
import 'package:mobile_exam/screens/exam/data_events.dart';
import 'package:mobile_exam/screens/exam/data_repository.dart';
import 'package:mobile_exam/screens/exam/data_state.dart';

class ViewState extends base.ViewState {
  @override
  Widget content(BuildContext context) {
    final arg = context.arguments;
    return RepositoryProvider(
      create: (context) => DataRepository(),
      child: BlocProvider(
        create: (context) =>
            DataBloc(RepositoryProvider.of<DataRepository>(context), context)
              ..add(LoadDataEvent()),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<DataBloc, DataState>(builder: (context, state) {
              if (state is DataLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is DataLoadedState) {
                DataModel dataResult = state.data;
                if (dataResult.statusCode == 200) {
                  return Column(
                    children: [
                      Card(child: Text(dataResult.message)),
                      Image.network(dataResult.image),
                      Text(dataResult.count.toString()),
                      TextButton(
                          onPressed: () {
                            context.server.addToCount(1);
                          },
                          child: Text('Add Count'))
                    ],
                  );
                }
              }
              if (state is DataErrorState) {
                return Center(child: Text("Error"));
              }

              return Container();
            })),
      ),
    );
  }
}
