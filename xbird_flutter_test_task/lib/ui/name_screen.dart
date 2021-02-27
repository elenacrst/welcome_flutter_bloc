import 'file:///D:/flutter_apps/xbird_flutter_test_task/xbird_flutter_test_task/lib/blocs/form/form_bloc.dart';
import 'file:///D:/flutter_apps/xbird_flutter_test_task/xbird_flutter_test_task/lib/blocs/form/form_event.dart';
import 'package:xbird_flutter_test_task/blocs/agerange/age_range_bloc.dart';
import 'package:xbird_flutter_test_task/blocs/form/form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbird_flutter_test_task/consts.dart';
import 'age_range_screen.dart';

class NameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NameState();
  }
}

class NameState extends State<NameScreen> {
  String name;
  final _nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        context.read<FormBloc>().add(NameSubmit(name));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: whiteBackground,
          key: context.read<FormBloc>().scaffoldKey,
          // context.bloc<FormBloc>().scaffoldKey,
          body: BlocBuilder<FormBloc, FormChangedState>(
              builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: NameInput(),
                  ),
                  RaisedButton(
                    onPressed: state.isValidName
                        ? () {
                            /*Navigator.push(context,
                              MaterialPageRoute( builder: (_) => BlocProvider.value(value: BlocProvider.of<AgeRangeBloc>(context), child: AgeRangeScreen() ),
                          ));*/
                            Navigator.of(context).push(
                              MaterialPageRoute<AgeRangeScreen>(
                                builder: (_) => BlocProvider.value(
                                  value: BlocProvider.of<FormBloc>(context),
                                  child: BlocProvider<AgeRangeBloc>(
                                    create: (_) => AgeRangeBloc(),
                                    child: AgeRangeScreen(),
                                  ),
                                ),
                              ),
                            );
                          }
                        : () {},
                    child: Text('Next'),
                  )
                ],
              ),
            );
          })),
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({Key key, this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormChangedState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.name,
          focusNode: focusNode,
          decoration: state.isValidName
              ? InputDecoration(
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  errorText: null,
                  fillColor: fillInputColor,
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: focusedInputColor, width: 2),
                      borderRadius: BorderRadius.circular(12)),
                )
              : InputDecoration(
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: fillInputColor,
                  errorText: 'Please enter a name',
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: errorInputColor, width: 2),
                      borderRadius: BorderRadius.circular(12)),
                ),
          keyboardType: TextInputType.name,
          onChanged: (value) {
            context.read<FormBloc>().add(NameChanged(name: value));
          },
          textInputAction: TextInputAction.go,
        );
      },
    );
  }
}
