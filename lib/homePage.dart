import 'package:class_grade_tracker/colorData.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: uiColors.standard,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10,),

              const Text('Welcome!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),

              const SizedBox(height: 10,),

              const Text('Please choose to configure students or grades.',),

              const SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: uiColors.students,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/students').then((value) => setState(() {}));
                      },
                      child: SizedBox(
                        width: 300,
                        height: 500,
                        child: Column(
                          children: const <Widget> [
                            SizedBox(height: 20,),
                            Text(
                              'Students',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                //fontWeight: FontWeight.w500,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Icon(
                              //Icons.account_circle_sharp,
                              Icons.emoji_people,
                              size: 300,
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 80,),

                  Card(
                    color: uiColors.grades,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/classGrades').then((value) => setState(() {}));
                      },
                      child: SizedBox(
                        width: 300,
                        height: 500,
                        child: Column(
                          children: const <Widget> [
                            SizedBox(height: 20,),
                            Text(
                              'Grades',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                //fontWeight: FontWeight.w500,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Icon(
                              Icons.data_exploration_outlined,
                              size: 300,
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}