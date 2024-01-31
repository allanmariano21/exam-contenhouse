import 'package:flutter/widgets.dart';
import 'package:mobile_exam/models/data_model.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class DataState extends Equatable {}

//data loading state
class DataLoadingState extends DataState {
  @override
  List<Object?> get props => [];
}

class DataLoadedState extends DataState {
  DataLoadedState(this.data);
  final DataModel data;

  @override
  List<Object?> get props => [data];
}

class DataErrorState extends DataState {
  DataErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}
