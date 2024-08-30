// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sort_child_properties_last, unused_element, unused_local_variable, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use

import 'package:flutter/material.dart';
import "dart:async";
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Reduced(),
    );
  }
}

class Reduced extends StatefulWidget {
  const Reduced({super.key});

  @override
  State<Reduced> createState() => _ReducedState();
}

class _ReducedState extends State<Reduced> {
  Duration duration = Duration(seconds: 0);
  Timer? repeatedfunc;
  bool isRunning = false;
  Start() {
    repeatedfunc = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int increaseSeconds = duration.inSeconds + 1;
        duration = Duration(seconds: increaseSeconds);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 49, 15, 15),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children :[ CircularPercentIndicator(
              radius: 175.0,
              center: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      duration.inHours.toString().padLeft(2, "0"),
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
            
                  SizedBox(width: 15,),
            
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      duration.inMinutes.remainder(60).toString().padLeft(2, "0"),
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
            
                  SizedBox(width: 15,),
            
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      duration.inSeconds.remainder(60).toString().padLeft(2, "0"),
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
            
                   
                   
                ],
              ),
              progressColor: Color.fromARGB(255, 56, 44, 232),
              backgroundColor: Colors.grey,
              lineWidth: 8.0,
              percent: duration.inSeconds.remainder(60) / 59,
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 250,
            ),

            SizedBox(height: 220,),

            isRunning
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (repeatedfunc!.isActive) {
                          repeatedfunc!.cancel();
                        } else {
                          Start();
                        }
                      },
                      child: Text(
                        repeatedfunc!.isActive ? "Pause" : "Resume",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11))),
                      ),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        repeatedfunc!.cancel();
                        setState(() {
                          duration = Duration(seconds: 0);
                          isRunning = false;
                        });
                      },
                      child: Text(
                        "Reset",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11))),
                      ),
                    ),
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isRunning = true;
                    });

                    Start();
                  },
                  child: Text(
                    "Start",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11))),
                  ),
                ),
          ]),
        ));
  }
}
