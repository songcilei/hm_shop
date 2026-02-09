import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';
class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  HmSlider({Key? key,required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  
  //在flutter中获取屏幕宽度的方法
  double _getWidth(){
    return MediaQuery.of(context).size.width;
  }
  List<Widget> _getSlider(){
    return [
      CarouselSlider(
        items: List.generate(widget.bannerList.length, (int index){
          return Container(
            child: Image.network(widget.bannerList[index].imgUrl!,fit: BoxFit.cover,width: _getWidth()),//网络图片
          );
      }), 
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        height: 300,
        autoPlayInterval: Duration(seconds: 3)))
    ];
  }

  @override
  Widget build(BuildContext context) {
    // stack =>轮播图 搜索框 指示灯导航
    return Stack(
      children: _getSlider(),
    );
  }
}