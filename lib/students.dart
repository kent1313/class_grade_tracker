import 'package:class_grade_tracker/colorData.dart';
import 'package:class_grade_tracker/readExcel.dart';
import 'package:flutter/material.dart';

class Students extends StatefulWidget {
  const Students({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  @override
  Widget build(BuildContext context) {
    List<Student> students = excelCommands.getStudents();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: uiColors.students,
        ),
        body: Center(
            child: ListView.builder(
                itemBuilder: (_, index) {
                  Color grey = const Color.fromRGBO(350, 350, 350, 0.05);
                  double hue = students[index].score >= 50 ? ((11/5) * students[index].score) - 110: 0;
                  return ListTile(
                    tileColor: index.isOdd ? grey: null,
                    leading: Icon(Icons.account_circle, color: uiColors.students),
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          '/studentInfo',
                          arguments: '${students[index].firstName} ${students[index].lastName}'
                      ).then((value) => setState(() {}));
                    },
                    title: Text(students[index].firstName.toString()),
                    subtitle: Text(students[index].lastName.toString()),
                    trailing: Icon(
                      students[index].score < 60 ? Icons.error:
                      students[index].score >= 80 ? Icons.check_circle:
                      Icons.warning,
                      color: HSLColor.fromAHSL(1, hue, 1, 0.5).toColor(),
                      size: 30,
                    ),
                  );
                },
                itemCount: students.length
            )
        )

    );
  }
}

class Student {
  String firstName;
  String lastName;
  double score;

  Student(this.firstName, this.lastName, this.score);
}