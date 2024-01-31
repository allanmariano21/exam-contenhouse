import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_exam/core/services/server.dart';
import 'package:mobile_exam/screens/exam/data_events.dart';
import 'package:mobile_exam/screens/exam/data_repository.dart';
import 'package:mobile_exam/screens/exam/data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final DataRepository _dataRepository;

  DataBloc(this._dataRepository, BuildContext context)
      : super(DataLoadingState()) {
    on<LoadDataEvent>((event, emit) async {
      emit(DataLoadingState());
      try {
        final users = await _dataRepository.getData(context);

        emit(DataLoadedState(users));
      } catch (e) {
        emit(DataErrorState(e.toString()));
      }
    });
  }
}
