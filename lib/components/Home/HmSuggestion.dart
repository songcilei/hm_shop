
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';
class HmSuggestion extends StatefulWidget {

  final SpecialOfferResult specialOfferList;
  const HmSuggestion({super.key,required this.specialOfferList});

  @override
  _HmSuggestionState createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  Widget _buildHeader(){
    return Row(
      children: [
        Text("特惠推荐",style: TextStyle(color: Color.fromARGB(255,86,24,20),fontSize: 18,fontWeight: FontWeight.w700)),
        SizedBox(width: 10),
        Text("精选省攻略",style: TextStyle(color: Color.fromARGB(255, 170, 57, 48),fontSize: 18,fontWeight: FontWeight.w700))
      ],
    );
  }

  //左侧结构
  Widget _buildLeft(){
    return  Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(image:AssetImage("lib/assets/home_cmd_inner.png"),
        fit: BoxFit.cover)
      ),
    );
  }

  List<SpecialOfferGoodsItem> _GetDisplayItems(){
    if(widget.specialOfferList.subTypes!.isEmpty) return [];//初始化 还没获取到的时候

    return widget.specialOfferList.subTypes!.first.goodsItems!.items!.take(3).toList();//take 代表取前几条
  }
List<Widget> _getChildrenList(){
  List<SpecialOfferGoodsItem> list = _GetDisplayItems();
  return List.generate(list.length, (int index){
    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
        errorBuilder: (context,error,StackTrace){//当图片返回失败时  加载这个
          return Image.asset("lib/assets/home_cmd_inner.png",width: 100,height: 140,);
        } ,
        list[index].picture!,
        fit: BoxFit.cover,
        width: 100,
        height: 140,
        )

      ),
      SizedBox(width: 10,),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255,240,94,12),
        ),
        child: Text("${list[index].price}",style: TextStyle(color: Colors.white),),
      )
    ],);
  });
}

  //完成渲染
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.all(12),
        // height: 300,
        alignment: Alignment.center,//居中对齐
        decoration: BoxDecoration(
          color:Colors.blue,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(//这个可以增加背景图
            image: AssetImage("lib/assets/home_cmd_sm.png",),
            fit: BoxFit.cover
          )
        ),        
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(width: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_buildLeft(),Expanded(child: Row(children: _getChildrenList()))],
            )
          ],
        ),
      ),
    );
  }
}
