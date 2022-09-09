//

import 'package:class_grade_tracker/colorData.dart';
import 'package:class_grade_tracker/readExcel.dart';
import 'package:flutter/material.dart';
import 'studentInfo.dart';

class ClassGrades extends StatefulWidget {
  const ClassGrades({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ClassGrades> createState() => _ClassGradesState();
}

class _ClassGradesState extends State<ClassGrades> {
  @override
  Widget build(BuildContext context) {
    List<Grade> grades = excelCommands.getGrades();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: uiColors.grades,
        ),
        body: Center(
            child: ListView.builder(
                itemBuilder: (_, index) {
                  Color grey = const Color.fromRGBO(350, 350, 350, 0.05);
                  double averageGrade = (grades[index].answered/grades[index].length) * 100;
                  double hue = averageGrade >= 50 ? ((11/5) * averageGrade) - 110: 0;
                  return ListTile(
                    tileColor: index.isOdd ? grey: null,
                    leading: Icon(Icons.assignment_turned_in, color: uiColors.grades),
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          '/assignmentGradesInfo',
                          arguments: grades[index].assignment
                      ).then((value) => setState(() {}));
                    },
                    title: Text(grades[index].assignment),
                    //subtitle: Text(),
                    trailing: Icon(
                      averageGrade < 60 ? Icons.error:
                      averageGrade >= 80 ? Icons.check_circle:
                      Icons.warning,
                      color: HSLColor.fromAHSL(1, hue, 1, 0.5).toColor(),
                      size: 30,
                    ),
                  );
                },
                itemCount: grades.length
            )
        )

    );
  }
}