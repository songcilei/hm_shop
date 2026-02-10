import 'package:flutter/material.dart';
class HmSuggestion extends StatefulWidget {
  const HmSuggestion({super.key});

  @override
  _HmSuggestionState createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 300,
        alignment: Alignment.center,//居中对齐
        color: Colors.blue,
        child: Text("推荐"),
      ),
    );
  }
}