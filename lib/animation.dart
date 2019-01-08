import 'package:flutter/material.dart';

class Animate extends StatefulWidget{

  @override
  AnimateState createState()=> AnimateState();

}


class AnimateState extends State<Animate> with SingleTickerProviderStateMixin{
  
  AnimationController controller;
  Animation <double> animation;
  @override
  void initState(){
   super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller,curve: Curves.easeOut);
    animation.addListener((){
      this.setState((){});
    });
    animation.addStatusListener((AnimationStatus status){
    });
    controller.repeat();
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          color: Colors.white,
          height: 3.0,
          width: animation.value * 100.0,
        ),
        Padding(padding: EdgeInsets.only(bottom: 5.0)),
        Container(
          color: Colors.white,
          height: 3.0,
          width: animation.value * 70.0,
        ),
        Padding(padding: EdgeInsets.only(bottom: 5.0)),
        Container(
          color: Colors.white,
          height: 3.0,
          width: animation.value * 50.0,
        ),
      ],
    );
  }
}