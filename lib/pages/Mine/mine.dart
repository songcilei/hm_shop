import 'package:flutter/cupertino.dart';

class MineView extends StatefulWidget {
  const MineView({super.key});

  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("我的"),
    );
  }
}