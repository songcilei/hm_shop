import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';
class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;

  const HmSlider({super.key,required this.bannerList});

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  final CarouselSliderController _carouselController = CarouselSliderController();//这个是轮播图控制器  用来控制一些操作的 
  int _currentIndex =0;
  //在flutter中获取屏幕宽度的方法
  double _getWidth(){
    return MediaQuery.of(context).size.width;
  }
//搜索框
  Widget _getSearch(){
    return Container(
      margin:EdgeInsets.only(top: 10,left: 10,right: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(136, 71, 71, 71),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.search,color: Colors.grey[400],),
          Text('搜索',style: TextStyle( fontSize: 15, color: Colors.grey[400]),),
        ],
      ),
    );
  }

  Widget _getSlider(){
    return 
      CarouselSlider(
        carouselController: _carouselController,//这个是轮播图控制器  用来控制一些操作的
        items: List.generate(widget.bannerList.length, (int index){
          return Container(
            child: Image.network(widget.bannerList[index].imgUrl!,fit: BoxFit.cover,width: _getWidth()),//网络图片
          );
        }), 
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: false,
          height: 300,
          autoPlayInterval: Duration(seconds: 3),
          onPageChanged: (int index,CarouselPageChangedReason reason){//轮播图切换回调事件
            setState(() {
              _currentIndex = index;
            });
          }
        )
      );
  }

  Widget _getDots(){
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerList.length, (int index){
            return GestureDetector(
              onTap: (){
                _carouselController.animateToPage(index);//这个用来操控轮播图  有点类似vue 的 ref属性
              },
              child: AnimatedContainer(//动画包裹组件
                duration: Duration(milliseconds: 300),
                height: 6,
                width: index==_currentIndex?40:20,
                margin: EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: index==_currentIndex?Colors.red:Color.fromRGBO(0,0,0,0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );  
          }),
        ),)
      );
  }


  @override
  Widget build(BuildContext context) {
    // stack =>轮播图 搜索框 指示灯导航
    return Stack(
      children: [_getSlider(),_getSearch(),_getDots()],
    );
  }
}