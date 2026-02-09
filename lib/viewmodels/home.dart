class BannerItem{
  String? id;
  String? imgUrl;
  BannerItem({required this.id,required this.imgUrl});

  //扩展一个工厂函数  一般用factory 来声明 一般用来创建实例对象
  factory BannerItem.fromJson(Map<String,dynamic> json){
    return BannerItem(
      id: json['id'] ?? "",//这里是从json 内取数据  ?? 是空判定
      imgUrl: json['imgUrl'] ?? "",//这里是从json 内取数据
    );
  }

}//每一个轮播图的具体类型