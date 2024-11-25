import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';


class Pagess extends StatefulWidget {
  const Pagess({super.key});

  @override
  State<Pagess> createState() => _PagessState();
}

class _PagessState extends State<Pagess> {
  late PageController controller;
  List<Widget>pages = [
    Page(),
    Pagess1(),
    Pagess2()
  ];
  int current = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController();
    atuo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller = PageController();
  }
  void atuo(){
    Timer.periodic(Duration(seconds: 3), (Timer t){
      if(current==pages.length-1){
        setState(() {
          current=0;
        });
      }else if(current==pages.length-1){
        setState(() {
          current++;
        });
        setState(() {
          controller.animateToPage(current, duration: Duration(seconds: 3), curve: Curves.linear);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            PageView(
              onPageChanged: (int index) {
                setState(() {
                  current = index;
                });
              },
              controller: controller,
              children: pages,
            ),
            Positioned(
              bottom: 10,
              left: 175,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 8,
                    backgroundColor: current == 0 ? Colors.black : Colors
                        .blueGrey,
                  ),
                  CircleAvatar(
                    radius: 8,
                    backgroundColor: current == 1 ? Colors.black : Colors
                        .blueGrey,
                  ),
                  CircleAvatar(
                    radius: 8,
                    backgroundColor: current == 2 ? Colors.black : Colors
                        .blueGrey,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 59,
              right: 10,
              child: ElevatedButton(onPressed: (){
                next();
              }, child: Icon(Icons.keyboard_double_arrow_right)),
            )

          ],
        )
    );
  }
  void next(){
    if(current==pages.length-1){
      setState(() {
        current=0;
      });
    }else if(current<pages.length-1){
      setState(() {
        current++;
      });
    }
    setState(() {
      controller.animateToPage(current, duration: Duration(seconds: 3), curve: Curves.linear);
    });
  }

}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(top: 200,
                left: 70,
                child: Image(image: AssetImage("assets/images/images.jpg"))),
            Positioned(top: 385,
                left: 150,
                child: Text("DONATE",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red

                ),)),
            Positioned(top: 400,
                left: 149,
                child: Text("BLOOD",style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),)),
            Positioned(top: 430,
                left: 150,
                child: Text("SAVE LIFE",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                ),)),
          ],
        )

    );
  }
}

class Pagess1 extends StatefulWidget {
  const Pagess1({super.key});

  @override
  State<Pagess1> createState() => _Pagess1State();
}

class _Pagess1State extends State<Pagess1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: 200,
              left: 46,
              child: Image(image: AssetImage("assets/images/page3.jpg"))),
          Positioned(top: 385,
              left: 80,
              child: Text("You Can Easly Find Out Blood Donor ",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red

              ),)),

        ],
      ),
    );
  }
}
class Pagess2 extends StatefulWidget {
  const Pagess2({super.key});

  @override
  State<Pagess2> createState() => _Pagess2State();
}

class _Pagess2State extends State<Pagess2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(top: 200,
                left: 65,
                child: Image(image: AssetImage("assets/images/page2.jpg"))),
            Positioned(top: 385,
                left: 150,
                child: Text("EAVERY DROP",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red

                ),)),
            Positioned(top: 400,
                left: 139,
                child: Text("Counts Be A",style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),)),
            Positioned(top: 430,
                left: 150,
                child: Text("blood Donor ",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                ),)),
            Positioned(bottom: 10,
                right: 10,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return HomePage();
                  }));
                }, child: Text("Home")))
          ],
        )

    );
  }

}




