// ignore_for_file: public_member_api_docs, sort_constructors_first
// Definition ---> agr humain code kisi sequence main run krna hai to hum template method use kraingy
// ye 1 behaviorul design pattern hai
// e.g: read--> process--> write
// e.g2: read from api --> process --> store to db

// Primitive operations — abstract operations that must be implemented by subclasses; concrete operations that provide a default implementation and can be redefined by subclasses if necessary.
// Final operations — concrete operations that can not be overridden by subclasses.
// Hook operations — concrete operations which provide default behaviour that subclasses can extend if necessary. A hook operation often does nothing by default.
// Template method itself can be declared as final so that it could not be overridden by subclasses.
// agr is method ko or acha krna hai to hum below given api classes ko adapter pattern k sath mazeed use kr skty hain
import 'dart:convert';
import 'dart:math' as math;

import 'package:meta/meta.dart';
import 'package:xml/xml.dart' as xml;

void main(List<String> args) {
  print(StudentsJsonBmiCalculator().calculateBmiAndReturnStudentsList());
}

abstract class StudentBmiCalculator {
  List<Student> calculateBmiAndReturnStudentsList() {
    var studentList = getStudentData();
    studentList = doStudentFiltering(studentList);
    _calculateStudentBmi(studentList);
    return studentList;
  }

  void _calculateStudentBmi(List<Student> studentList) {
    for (var student in studentList) {
      student.bmi = _calculateBmi(student.height, student.weight);
    }
  }

  double _calculateBmi(double height, int weight) {
    return weight / math.pow(height, 2);
  }

  //hook method
  List<Student> doStudentFiltering(List<Student> studentList) {
    return studentList;
  }

  //abstract
  @protected
  List<Student> getStudentData();
}

class StudentsXmlBmiCalculator extends StudentBmiCalculator {
  final XmIStudentsApi _api = XmIStudentsApi();
  @override
  List<Student> getStudentData() {
    var studentsXml = _api._studentsXml;
    var xmlDocument = xml.parse(studentsXml);
    List<Student> studentsList = [];

    for (var xmlElement in xmlDocument.findAllElements('student')) {
      var fullName = xmlElement.findElements('fullname').single.text;
      var age = int.parse(xmlElement.findElements('age').single.text);
      var height = double.parse(xmlElement.findElements('height').single.text);
      var weight = int.parse(xmlElement.findElements('weight').single.text);
      studentsList.add(Student(
          fullName: fullName,
          age: age,
          height: height,
          weight: weight,
          bmi: 0));
    }
    return studentsList;
  }
}

class StudentsJsonBmiCalculator extends StudentBmiCalculator {
  final studentJsonAdapter = AdapterJsonStudent();
  //parsing with adapter pattern
  @override
  List<Student> getStudentData() {
    return studentJsonAdapter.getStudentList();
  }

  @override
  List<Student> doStudentFiltering(List<Student> studentList) {
    return studentJsonAdapter
        .getStudentList()
        .where((student) => student.age > 12 && student.age < 20)
        .toList();
  }

  //normal parsing
  /*  final _api = JsonStudentsApi();
  @override
  List<Student> getStudentData() {
    var studentJson = _api._studentsJson;
    var studentsMap = jsonDecode(studentJson) as Map<String, dynamic>;
    var studentJsonList = studentsMap['students'] as List;
    List<Student> studentsList = studentJsonList
        .map((json) => Student(
              fullName: json["fullName"],
              age: json["age"],
              weight: json["weight"],
              height: json["height"],
              bmi: 0,
            ))
        .toList();
    return studentsList;
  } */

}

class TeenageStudenJsonBmiCalculator extends StudentBmiCalculator {
  final _api = JsonStudentsApi();

  @override
  List<Student> getStudentData() {
    var studentJson = _api._studentsJson;
    var studentsMap = jsonDecode(studentJson) as Map<String, dynamic>;
    var studentJsonList = studentsMap['students'] as List;
    List<Student> studentsList = studentJsonList
        .map((json) => Student(
            fullName: json["fullName"],
            age: json["age"],
            weight: json["weight"],
            height: json["height"],
            bmi: 0))
        .toList();
    return studentsList;
  }

  @override
  @protected
  List<Student> doStudentFiltering(List<Student> studentList) {
    return studentList
      ..where((student) => student.age > 12 && student.age < 20).toList();
  }
}

// For advance variant
abstract class AdapterStudentResponse {
  List<Student> getStudentList();
}

class AdapterJsonStudent extends AdapterStudentResponse {
  final _api = JsonStudentsApi();

  @override
  List<Student> getStudentList() {
    var studentJson = _api._studentsJson;
    var studentsMap = jsonDecode(studentJson) as Map<String, dynamic>;
    var studentJsonList = studentsMap['students'] as List;
    List<Student> studentsList = studentJsonList
        .map((json) => Student(
              fullName: json["fullName"],
              age: json["age"],
              weight: json["weight"],
              height: json["height"],
              bmi: 0,
            ))
        .toList();
    return studentsList;
  }
}

class Student {
  final String fullName;
  final int age;
  final double height;
  final int weight;
  double bmi;
  Student({
    required this.fullName,
    required this.age,
    required this.height,
    required this.weight,
    required this.bmi,
  });
}

class JsonStudentsApi {
  final String _studentsJson = '''{
  "students": [
    {
      "fullName": "John Doe",
      "age": 12,
      "height": 1.62,
      "weight": 53
    },
    {
      "fullName": "Emma Doe",
      "age": 15,
      "height": 1.55,
      "weight": 50
    },
    {
      "fullName": "Michael Roe",
      "age": 18,
      "height": 1.85,
      "weight": 89
    },
    {
      "fullName": "Emma Roe",
      "age": 20,
      "height": 1.66,
      "weight": 79
    }
  ]
}''';
  String getStudentsJson() {
    return _studentsJson;
  }
}

class XmIStudentsApi {
  final String _studentsXml = '''
<?xml version="1.0"?>
<students>
	<student>
		<fullname> John Doe (XML) </fullname>
		<age>12</age>
		<height>1.62</height>
		<weight> 53</weight>
	</student>
	<student>
		<fullname> Emma Doe (XML) </fullname>
		<age>15</age>
		<height>1.55</height>
		<weight> 50</weight>
	</student>
	<student>
		<fullname>Michael Roe (XML) </fullname>
		<age> 18</age>
		<height>1.85</height>
		<weight>89</weight>
	</student>
	<student>
		<fullname> Emma Roe (XML)</fullname>
		<age>20</age>
		<height> 1.66</height>
		<weight>79</weight>
	</student>
</students>''';
  String getStudentsJson() {
    return _studentsXml;
  }
}
