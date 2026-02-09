import 'package:flutter/material.dart';

class HmCategory extends StatefulWidget {
  HmCategory({Key? key}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    //return listView
    //返回一个横向滚动组件
    return SizedBox(
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 80.0,
          height: 100.0,
          color: Colors.blue,
          margin: EdgeInsets.symmetric(horizontal: 10.0),//横间距
          alignment: Alignment.center,//居中对齐
          child: Text("分类$index",style: TextStyle(color: Colors.white,fontSize: 20.0)),
        );
       },
      ),
    );
  }
}