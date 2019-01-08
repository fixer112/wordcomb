import 'package:flutter/material.dart';

class Lister extends StatefulWidget{
  Lister({this.data});
  final List data;
  @override
  ListerState createState()=> ListerState();
}

class ListerState extends State<Lister>{
  @override
  Widget build(BuildContext context){
    return Container(
      child: Center(
        child:ListView.builder(
          itemCount: widget.data == null ? 0 : widget.data.length ,
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: Container(
                padding:EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      //margin: EdgeInsets.all(15.0),
                      //padding: EdgeInsets.all(15.0),
                      height: 25.0,
                      width: 25.0,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.blue),
                      child:Center(
                        child: Text((index+1).toString()),
                      )
                    ),
                    Text(widget.data[index]),
                  ],
                ),
              )
                
            );
          },
        )
      ),
    );
  }
}