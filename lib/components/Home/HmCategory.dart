import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  // 分类列表
  final List<CategoryItem> categoryList;
  const HmCategory({super.key,required this.categoryList});

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
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
        // 从分类列表中获取数据
        final category = widget.categoryList[index];
        return Container(
          width: 80.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: Color.fromARGB(255,231,232,234),
            borderRadius: BorderRadius.circular(40.0),//圆角
          ),
          margin: EdgeInsets.symmetric(horizontal: 10.0),//横间距
          alignment: Alignment.center,//居中对齐
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,//垂直居中对齐
            children: [
              // 分类图标
              Image.network(category.picture!,width: 40.0,height: 40.0,),
              Text(category.name!,style: TextStyle(color: Colors.black,fontSize: 13.0)),
            ],
          ),
        );
       },
      ),
    );
  }
}