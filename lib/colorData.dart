import 'package:flutter/material.dart';

Colors uiColors = Colors(
    const Color.fromRGBO(76, 76, 76, 1),    //Dark Grey
    const Color.fromRGBO(136, 192, 71, 1),  //Dark Green
    const Color.fromRGBO(123, 84, 70, 1),   //Brown
);

class Colors {
  Color standard;
  Color students;
  Color grades;

  Colors(this.standard, this.students, this.grades);
}