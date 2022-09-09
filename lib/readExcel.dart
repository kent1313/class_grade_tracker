// @dart=2.9

import 'dart:io';
import 'package:class_grade_tracker/assignmentGradesInfo.dart';
import 'package:class_grade_tracker/studentInfo.dart';
import 'package:class_grade_tracker/students.dart';
import 'package:excel/excel.dart';

ExcelCommands excelCommands = ExcelCommands();

class ExcelCommands {

  List<Student> getStudents() {
    var file = "/home/kent/Documents/School/GCS/ExcelTestSheet.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    List<Student> names = [];
    List<int> examLength = [];
    int counter;

    for (var table in excel.tables.keys) {
      counter = 0;
      for (var row in excel.tables[table]?.rows ?? []) {
        if(counter == 1) {
          for(var i = 0; i < row.length; i++) {
            if(i == 0) {
              examLength.add(-1);
            } else {
              examLength.add(row[i]);
            }
          }
        }

        if(counter > 1) {
          var name = row[0].toString().split(' ');
          String firstName = name[0];
          String lastName = name[1];
          int exams = row.length - 1;

          double sum = 0;
          for(var i = 1; i < row.length; i++) {
            if(row[i] == null) {
              exams--;
            } else {
              sum = sum + (row[i]/examLength[i]);
            }
          }
          double grade = sum/exams;

          names.add(Student(firstName, lastName, grade * 100));
        }
        counter++;
      }
    }
    return names;
  }

  List<Grade> getStudentGrades(String name) {
    List<Student> students = excelCommands.getStudents();
    if(students.isEmpty) {
      return [];
    }

    var file = "/home/kent/Documents/School/GCS/ExcelTestSheet.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    List<Grade> grades = [];
    int totalQuestions = 0;
    int totalAnswered = 0;
    for(var i = 0; i < students.length; i++) {
      if('${students[i].firstName} ${students[i].lastName}' == name) {
        List<String> assignments = [];
        List<int> length = [];
        List<int> answered = [];
        for (var table in excel.tables.keys) {
          for (var c = 0; c < excel.tables[table]?.rows?.length; c++) {
            var row = excel.tables[table]?.rows[c];
            if(c == 0) {
              for(var n = 1; n < row.length; n++) {
                assignments.add(row[n].toString());
              }
            }
            if(c == 1) {
              for(var n = 1; n < row.length; n++) {
                length.add(row[n]);
                totalQuestions += row[n];
              }
            }
            if(c == i + 2) {
              for(var n = 1; n < row.length; n++) {
                if(row[n] == null) {
                  answered.add(-1);
                  totalQuestions -= length[length.length-1];
                } else {
                  answered.add(row[n]);
                  totalAnswered += row[n];
                }
              }
            }
          }
        }

        for(var n = 0; n < assignments.length; n++) {
          grades.add(Grade(assignments[n], length[n], answered[n]));
        }
      }
    }
    grades.add(Grade('Average', totalQuestions, totalAnswered));
    return grades;
  }

  List<Grade> getGrades() {
    var file = "/home/kent/Documents/School/GCS/ExcelTestSheet.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    List<Grade> grades = [];
    List<String> assignments = [];
    List<int> lengths = [];
    List<List<int>> scores = [];
    List<int> totalQuestions = [];
    List<int> totalAnswers = [];

    for (var table in excel.tables.keys) {
      for (var i = 0; i < excel.tables[table].rows.length; i++) {
        var row = excel.tables[table].rows[i];
        if(i == 0) {
          for(var n = 1; n < row.length; n++) {
            assignments.add(row[n].toString());
            scores.add([]);
          }
        }
        if(i == 1) {
          for(var n = 1; n < row.length; n++) {
            lengths.add(row[n]);
          }
        }
        if(i > 1) {
          for(var n = 1; n < row.length; n++) {
            if(row[n] == null) {
              scores[n-1].add(-1);
            } else {
              scores[n-1].add(row[n]);
            }
          }
        }
      }
    }
    int turnIns;
    int sum;
    for(var i = 0; i < scores.length; i++) {
      turnIns = 0;
      sum = 0;
      for(var n = 0; n < scores[i].length; n++) {
        if(scores[i][n] != -1) {
          sum += scores[i][n];
          turnIns++;
        }
      }
      totalQuestions.add(turnIns * lengths[i]);
      totalAnswers.add(sum);
    }
    for(var i = 0; i < assignments.length; i++) {
      grades.add(Grade(assignments[i], totalQuestions[i], totalAnswers[i]));
    }
    return grades;
  }

  List<StudentScore> getGradeStudents(String assignment) {
    var file = "/home/kent/Documents/School/GCS/ExcelTestSheet.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    List<StudentScore> scores = [];

    int assignmentIndex;
    int questions = 0;
    for (var table in excel.tables.keys) {
      for(var i = 0; i < excel.tables[table].rows[0].length; i++) {
        var cell = excel.tables[table].rows[0][i].toString();
        if(cell == assignment) {
          assignmentIndex = i;
        }
      }
      for (var i = 1; i < excel.tables[table].rows.length; i++) {
        var row = excel.tables[table].rows[i];
        if(i == 1) {
          questions = row[assignmentIndex];
        }
        if(i > 1) {
          if(row[assignmentIndex] == null) {
            scores.add(StudentScore(row[0], -1));
          } else {
            scores.add(StudentScore(row[0], row[assignmentIndex]/questions));
          }
        }
      }
    }

    return scores;
  }
}