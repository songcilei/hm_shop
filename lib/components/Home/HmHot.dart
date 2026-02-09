import 'package:flutter/material.dart';
class HmHot extends StatefulWidget {
  HmHot({Key? key}) : super(key: key);

  @override
  _HmHotState createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,//居中对齐
      height: 200,
      child: Text("热门",style: TextStyle(color: Colors.white,fontSize: 20.0),),
    );
  }
}