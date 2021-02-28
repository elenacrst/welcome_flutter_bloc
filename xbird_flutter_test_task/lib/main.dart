import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbird_flutter_test_task/blocs/form/form_bloc.dart';
import 'package:xbird_flutter_test_task/blocs/agerange/age_range_bloc.dart';
import 'package:xbird_flutter_test_task/ui/name_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider<FormBloc>(
          create: (context) => FormBloc(),
          child: NameScreen(),
        ),
      ),
      providers: [
        BlocProvider<FormBloc>(create: (context) => FormBloc()),
        BlocProvider<AgeRangeBloc>(
          create: (context) => AgeRangeBloc(),
        )
      ],
    );
  }
}
