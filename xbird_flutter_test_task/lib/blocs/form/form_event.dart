abstract class FormEvent {
  const FormEvent();
}

class NameChanged extends FormEvent {
  final String name;

  NameChanged({this.name});
}

class NameSubmit extends FormEvent {
  final String name;

  NameSubmit(this.name);
}
