import 'file:///D:/flutter_apps/xbird_flutter_test_task/xbird_flutter_test_task/lib/blocs/form/form_bloc.dart';
import 'file:///D:/flutter_apps/xbird_flutter_test_task/xbird_flutter_test_task/lib/blocs/form/form_event.dart';
import 'package:flutter/services.dart';
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: whiteBackground,
          key: context.read<FormBloc>().scaffoldKey,
          // context.bloc<FormBloc>().scaffoldKey,
          body: BlocBuilder<FormBloc, FormChangedState>(
              builder: (context, state) {
            return Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 104),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTitleWidget(),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: _buildSubtitleWidget(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: _buildLabelWidget(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: NameInput(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: _buildErrorWidget(state.isValidName),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: _buildSubmitButton(state),
                    )
                  ],
                ));
          }),
        ));
  }

  Widget _buildTitleWidget() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Welcome onboard!',
          style: titleTextStyle)
    );
  }

  Widget _buildSubtitleWidget() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'First off, what should I call you?',
          style: TextStyle(
              color: subtitleTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans',
              letterSpacing: 0.1),
        ));
  }

  Widget _buildLabelWidget() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Your name',
          style: TextStyle(
              color: labelTextColor,
              fontSize: 14,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4),
        ));
  }

  Widget _buildErrorWidget(bool isValid) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        isValid ? '' : 'Please enter a name',
        style: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 14,
        letterSpacing: 0.4,
        color: errorColor,
      ),
      ),
    );
  }

  Widget _buildSubmitButton(FormChangedState state) {
    return RaisedButton(
      elevation: 0,
      onPressed: state.isValidName
          ? () {
        Navigator.of(context).push(
          MaterialPageRoute<AgeRangeScreen>(
            builder: (_) => BlocProvider.value(
              value: BlocProvider.of<FormBloc>(context),
              child: BlocProvider<AgeRangeBloc>(
                create: (_) => AgeRangeBloc(),
                child: AgeRangeScreen(state.name),
              ),
            ),
          ),
        );
      } : () {},
      child: Text(
          'Next',
        style: buttonTextStyle,
      ),
      textColor: selectedTextColor,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 14),
      color: selectedBackground,
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
          autofocus: true,
          decoration: InputDecoration(
            filled: true,
            contentPadding:
                EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
        //    errorText: state.isValidName ? null : 'Please enter a name',
            fillColor: fillInputColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: state.isValidName ? focusedInputColor : errorColor, width: 2),
                borderRadius: BorderRadius.circular(12)),
           /* focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: errorColor, width: 2),
                borderRadius: BorderRadius.circular(12)),*/
            /*errorStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              letterSpacing: 0.4,
              color: errorColor,
            ),*/
          ),
          keyboardType: TextInputType.name,
          onChanged: (value) {
            context.read<FormBloc>().add(NameChanged(name: value));
          },
          textInputAction: TextInputAction.go,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 16,
            letterSpacing: 0.1,
            color: inputTextColor,
          ),

        );
      },
    );
  }
}
