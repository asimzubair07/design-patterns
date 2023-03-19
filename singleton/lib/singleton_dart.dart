void main(List<String> arguments) {
  print(ExampleState._instance.stateText);
  ExampleState._instance.setStateText("New Text");
  print(ExampleState._instance.stateText);
}

abstract class ExampleStateBase {
  late String initialValue;
  late String stateText;
  String get currentText => stateText;

  void setStateText(String text) {
    stateText = text;
  }

  void reset() {
    stateText = initialValue;
  }
}

class ExampleState extends ExampleStateBase {
  static final ExampleState _instance = ExampleState._internal();
  factory ExampleState() {
    return _instance;
  }
  ExampleState._internal() {
    initialValue = "Initial Value";
    stateText = initialValue;
    // print(stateText);
  }
}
