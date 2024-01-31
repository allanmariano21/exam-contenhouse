import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DataEvent extends Equatable {
  const DataEvent();
}

class LoadDataEvent extends DataEvent {
  @override
  List<Object> get props => [];
}
