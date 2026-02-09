import 'package:flutter/material.dart';
class HmMoreList extends StatefulWidget {
  HmMoreList({Key? key}) : super(key: key);

  @override
  _HmMoreListState createState() => _HmMoreListState();
}

class _HmMoreListState extends State<HmMoreList> {

  final SliverGridDelegate _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
    childAspectRatio: 0.8,
  );

  @override
  Widget build(BuildContext context) {

    return SliverGrid.builder(
      gridDelegate: _gridDelegate, 
      itemBuilder: (BuildContext context,int index)
      {
        return Container(
          alignment: Alignment.center,
          color: Colors.grey[300],
          child: Text("商品"),
        );
      }
    );
  }
}