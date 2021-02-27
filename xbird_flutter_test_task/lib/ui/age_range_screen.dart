import 'file:///D:/flutter_apps/xbird_flutter_test_task/xbird_flutter_test_task/lib/blocs/form/form_bloc.dart';
import 'file:///D:/flutter_apps/xbird_flutter_test_task/xbird_flutter_test_task/lib/blocs/form/form_event.dart';
import 'package:xbird_flutter_test_task/blocs/form/form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbird_flutter_test_task/consts.dart';
import 'package:xbird_flutter_test_task/blocs/agerange/age_range_bloc.dart';
import 'package:xbird_flutter_test_task/blocs/agerange/age_range_state.dart';
import 'package:xbird_flutter_test_task/blocs/agerange/age_range_event.dart';

final List<String> ageRanges = [
  '< 30',
  '31 - 45',
  '46 - 55',
  '56 - 65',
  '66 - 75',
  '75 +'
];

class AgeRangeScreen extends StatefulWidget {
  AgeRangeScreen();

  @override
  _AgeRangeScreenState createState() => _AgeRangeScreenState();
}

class _AgeRangeScreenState extends State<AgeRangeScreen> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgeRangeBloc, AgeRangeState>(
        builder: (context, state) {
          return SafeArea(
              child: Scaffold(
              key: context.watch<AgeRangeBloc>().scaffoldKey,
          body:Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'How old are you?',
              ),
              Expanded(
                  child: Container(
                    // width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16, top: 24, left: 16, bottom: 24),
                      child: ListView.separated(
                        itemCount: ageRanges.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Chip(
                                label: Text(
                                  ageRanges[index],
                                  style: TextStyle(
                                      fontSize: 16,
                                    color: selectedIndex == index ? selectedTextColor : unselectedTextColor
                                  ),

                                ),
                                labelPadding: EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24)),
                                ),
                                backgroundColor: selectedIndex == index ? selectedBackground : unselectedBackground,

                              ),
                            ),
                            onTap: (){
                              selectedIndex = index;
                              context.read<AgeRangeBloc>().add(AgeRangeSelected(selectedIndex: index));
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index){
                          return SizedBox(
                            height: 8,
                          );
                        },
                      ),
                    ),)

              ),
              RaisedButton(
                onPressed: selectedIndex != -1 ? () {

                } : null,
                child: Text('Save'),
              )

            ],

          )));
        }
      //  )

    );
  }
}