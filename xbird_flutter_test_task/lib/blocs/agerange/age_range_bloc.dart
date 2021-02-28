import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:xbird_flutter_test_task/blocs/agerange/age_range_event.dart';
import 'package:xbird_flutter_test_task/blocs/agerange/age_range_state.dart';

class AgeRangeBloc extends Bloc<AgeRangeEvent, AgeRangeState> {
  AgeRangeBloc() : super(AgeRangeState());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey get scaffoldKey {
    return _scaffoldKey;
  }

  @override
  Stream<AgeRangeState> mapEventToState(AgeRangeEvent event) async* {
    if (event is AgeRangeSelected) {
      yield AgeRangeState(
        index: event.selectedIndex,
        hasSelection: true,
      );
    } else {
      yield AgeRangeState(
        index: -1,
        hasSelection: false,
      );
    }
  }
}
