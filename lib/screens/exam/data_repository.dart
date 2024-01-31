import 'package:flutter/material.dart';
import 'package:mobile_exam/core/app/bloc.dart';
import 'package:mobile_exam/core/services/server.dart';
import 'package:mobile_exam/models/data_model.dart';

class DataRepository {
  Future<DataModel> getData(BuildContext context) async {
    context.watch<Server>;
    final response = await context.server.data;
    DataModel data = DataModel.fromJson(response);
    return data;
  }
}
