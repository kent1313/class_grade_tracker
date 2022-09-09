// @dart=2.9

import 'package:class_grade_tracker/classGrades.dart';
import 'package:flutter/material.dart';
import 'assignmentGradesInfo.dart';
import 'homePage.dart';
import 'studentInfo.dart';
import 'students.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NumGrades',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),

        initialRoute: "/homePage",
        routes: {
          "/homePage": (context) => const HomePage(title: 'NumGrades'),
          "/classGrades": (context) => const ClassGrades(title: 'Assignments'),
          "/students": (context) => const Students(title: 'Students'),
          "/studentInfo": (context) => const StudentInfo(title: 'Students'),
          "/assignmentGradesInfo": (context) => const AssignmentGradesInfo(title: 'Grades'),
        }
    );
  }
}