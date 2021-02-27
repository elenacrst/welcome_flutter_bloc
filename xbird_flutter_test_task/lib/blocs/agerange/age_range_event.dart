abstract class AgeRangeEvent {
   AgeRangeEvent();
}

class AgeRangeSelected extends AgeRangeEvent {
  final int selectedIndex;
  AgeRangeSelected({this.selectedIndex});
}