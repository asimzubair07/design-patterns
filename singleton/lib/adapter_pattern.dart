// adapter pattern tb use hota h jb humari classes ka ya ksi bhi chz ka behaviour same ho
// but interface different ho like web & mobile UI
// jo source class hai i.e.. (API Client, 3rd Party Libraries)
// jo client ko dkhana h usko hum as an interface/abstract lengy

// for client side
abstract class IcontactAdaper {
  String getName();
}

//adaptee1
class FirstNameSource {
  final String name = "Asim";
  String getName() => name;
}

//adaptee2
class PehlaNameSource {
  final String name = "Aasim";
  String getName() => name;
}

class FirstNameAdapter extends IcontactAdaper {
  final _firstNameAdapter = FirstNameSource();
  @override
  String getName() {
    var firstName = _firstNameAdapter.getName();
    return firstName;
  }
}

class PehlaNameAdapter extends IcontactAdaper {
  final _pehlaNameAdapter = PehlaNameSource();
  @override
  String getName() {
    var phlNameAdapter = _pehlaNameAdapter.getName();
    return phlNameAdapter;
  }
}

void main(List<String> args) {
  print(FirstNameAdapter().getName());
}
