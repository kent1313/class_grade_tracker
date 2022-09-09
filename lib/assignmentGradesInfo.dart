import 'package:class_grade_tracker/colorData.dart';
import 'package:class_grade_tracker/readExcel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AssignmentGradesInfo extends StatefulWidget {
  const AssignmentGradesInfo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AssignmentGradesInfo> createState() => _AssignmentGradesInfoState();
}

class _AssignmentGradesInfoState extends State<AssignmentGradesInfo> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    double width = MediaQuery.of(context).size.width - 41;
    List<StudentScore> scores = excelCommands.getGradeStudents(args);

    return Scaffold(
        appBar: AppBar(
          title: Text(args),
          backgroundColor: uiColors.grades,
        ),
        body: Center(
            child: Stack(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      double score = scores[index].score;
                      int rounding = (score * 1000) ~/1;
                      double grade = rounding/10;
                      double hue = score*100 >= 50 ? ((11/5) * score * 100) - 110: 0;
                      String firstName = scores[index].name.split(' ')[0];
                      String lastName = scores[index].name.split(' ')[1];
                      return Row(
                        children: [
                          Visibility(
                              visible: index == 0,
                              child: const SizedBox(width: 70,)
                          ),
                          const SizedBox(
                            height: 520,
                            width: 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 1)
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                firstName,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              Text(
                                lastName,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              const SizedBox(height: 5,),
                              SizedBox(
                                  height: 520,
                                  width: 100,
                                  child: score >= 0 ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('$grade%'),
                                        SizedBox(
                                          width: 80,
                                          height: 500 * score,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: HSLColor.fromAHSL(1, hue, 1, 0.5).toColor(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ):

                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text('Incomplete', style: TextStyle(fontStyle: FontStyle.italic,),),
                                        SizedBox(
                                          width: 80,
                                          height: 50,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: const HSLColor.fromAHSL(1, 202, 1, 0.48).toColor(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                              //Components of equal height to keep SizedBox centered
                              const SizedBox(height: 5,),
                              const Text('', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                              const Text('', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)
                            ],
                          ),
                          Visibility(
                            visible: index == scores.length - 1,
                            child: const SizedBox(
                              height: 520,
                              width: 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 0, 1)
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: scores.length,
                  ),

                  //-----------------------
                  //Graph markings
                  //-----------------------
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(height: 20,),
                            Text('100%'),
                            SizedBox(height: 82,),
                            Text('80%'),
                            SizedBox(height: 82,),
                            Text('60%'),
                            SizedBox(height: 82,),
                            Text('40%'),
                            SizedBox(height: 82,),
                            Text('20%'),
                            SizedBox(height: 82,),
                            Text('0%'),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20,),
                            SizedBox(
                              height: 1,
                              width: scores.length * 102 + 2 > width ? width-30: scores.length * 102 + 2,
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(191, 191, 191, 1)
                                ),
                              ),
                            ),
                            const SizedBox(height: 98.8,),
                            SizedBox(
                              height: 1,
                              width: scores.length * 102 + 2 > width ? width-30: scores.length * 102 + 2,
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(191, 191, 191, 1)
                                ),
                              ),
                            ),
                            const SizedBox(height: 98.8,),
                            SizedBox(
                              height: 1,
                              width: scores.length * 102 + 2 > width ? width-30: scores.length * 102 + 2,
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(191, 191, 191, 1)
                                ),
                              ),
                            ),
                            const SizedBox(height: 98.8,),
                            SizedBox(
                              height: 1,
                              width: scores.length * 102 + 2 > width ? width-30: scores.length * 102 + 2,
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(191, 191, 191, 1)
                                ),
                              ),
                            ),
                            const SizedBox(height: 98.8,),
                            SizedBox(
                              height: 1,
                              width: scores.length * 102 + 2 > width ? width-30: scores.length * 102 + 2,
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(191, 191, 191, 1)
                                ),
                              ),
                            ),
                            const SizedBox(height: 98.8,),
                            SizedBox(
                              height: 1,
                              width: scores.length * 102 + 2 > width ? width-30: scores.length * 102 + 2,
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(191, 191, 191, 1)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]
            )
        )

    );
  }
}

class StudentScore {
  String name;
  double score;

  StudentScore(this.name, this.score);
}