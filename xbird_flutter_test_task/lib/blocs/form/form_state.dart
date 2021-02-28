class FormChangedState {
  final bool isValidName;
  final String name;
  final bool isSubmitted;

  const FormChangedState(
      {this.isValidName = true, this.name = '', this.isSubmitted = false});
}
