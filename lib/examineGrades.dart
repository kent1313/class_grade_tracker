ExamineGrades examineGrades = ExamineGrades();

class ExamineGrades {

  double average(List<double> grades) {
    double sum = 0;
    int length = 0;
    for(var i = 0; i < grades.length; i++) {
      if(grades[i] >= 0) {
        sum += grades[i];
        length++;
      }
    }
    double average = sum/length;
    return average;
  }

  double meanDeviation(List<double> grades) {
    double sum = 0;
    int length = 0;
    for(var i = 0; i < grades.length; i++) {
      if(grades[i] >= 0) {
        sum += grades[i];
        length++;
      }
    }
    double average = sum/length;
    sum = 0;
    for(var i = 0; i < grades.length; i++) {
      sum += (average - grades[i]).abs();
    }
    return sum/length;
  }
}