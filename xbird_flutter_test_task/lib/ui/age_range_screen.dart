import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbird_flutter_test_task/consts.dart';
import 'package:xbird_flutter_test_task/blocs/agerange/age_range_bloc.dart';
import 'package:xbird_flutter_test_task/blocs/agerange/age_range_state.dart';
import 'package:xbird_flutter_test_task/blocs/agerange/age_range_event.dart';
import 'package:xbird_flutter_test_task/repository/persistence_repository.dart';

final List<String> _ageRanges = [
  '< 30',
  '31 - 45',
  '46 - 55',
  '56 - 65',
  '66 - 75',
  '75 +'
];

class AgeRangeScreen extends StatefulWidget {
  final String name;

  AgeRangeScreen(this.name);

  @override
  _AgeRangeScreenState createState() => _AgeRangeScreenState();
}

class _AgeRangeScreenState extends State<AgeRangeScreen> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgeRangeBloc, AgeRangeState>(builder: (context, state) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          child: Scaffold(
              appBar: AppBar(
                leading: _buildBackButton(),
                backgroundColor: whiteBackground,
                shadowColor: Colors.transparent,
              ),
              backgroundColor: whiteBackground,
              key: context.watch<AgeRangeBloc>().scaffoldKey,
              body: Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTitleWidget(),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(
                                top: 24,
                              ),
                              child: _buildListWidget())),
                      _buildSubmitButton()
                    ],
                  ))));
    });
  }

  Widget _buildBackButton() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 48,
          width: 48,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: iconColor, // Return icon color
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ));
  }

  Widget _buildTitleWidget() {
    return Text('How old are you?', style: titleTextStyle);
  }

  Widget _buildListItemWidget(int index) {
    return GestureDetector(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Chip(
          label: Text(
            _ageRanges[index],
            style: TextStyle(
                fontSize: 16,
                color: selectedIndex == index
                    ? selectedTextColor
                    : unselectedTextColor,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.15),
          ),
          labelPadding:
              EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          backgroundColor: selectedIndex == index
              ? selectedBackground
              : unselectedBackground,
        ),
      ),
      onTap: () {
        selectedIndex = index;
        context
            .read<AgeRangeBloc>()
            .add(AgeRangeSelected(selectedIndex: index));
      },
    );
  }

  Widget _buildListWidget() {
    return ListView.separated(
      itemCount: _ageRanges.length,
      itemBuilder: (context, index) {
        return _buildListItemWidget(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 8,
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      onPressed: selectedIndex != -1
          ? () {
              PersistenceRepository()
                  .saveData(widget.name, _ageRanges[selectedIndex]);
            }
          : null,
      disabledColor: disabledButtonColor,
      disabledElevation: 0,
      disabledTextColor: disabledTextColor,
      elevation: 0,
      padding: EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 14),
      child: Text('Save', style: buttonTextStyle),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      color: selectedBackground,
      textColor: selectedTextColor,
    );
  }
}
