import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:xbird_flutter_test_task/blocs/form/form_event.dart';
import 'package:xbird_flutter_test_task/blocs/form/form_state.dart';

class FormBloc extends Bloc<FormEvent, FormChangedState> {
  FormBloc() : super(const FormChangedState());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey get scaffoldKey {
    return _scaffoldKey;
  }

  @override
  Stream<FormChangedState> mapEventToState(FormEvent event) async* {
    if (event is NameChanged) {
      yield FormChangedState(
          isValidName: event.name.isNotEmpty,
          name: event.name,
          isSubmitted: false);
    } else if (event is NameSubmit) {
      yield FormChangedState(
          isValidName: event.name.isNotEmpty,
          name: event.name,
          isSubmitted: true);
    }
  }
}
