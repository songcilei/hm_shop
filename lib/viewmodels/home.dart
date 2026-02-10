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




      //根据json编写class对象和工厂转化函数
      // 1. 编写class对象
      class CategoryItem{
        String? id;
        String? name;
        String? picture;
        List<CategoryItem>? children;
        List<GoodsItem>? goods;
        CategoryItem({required this.id,required this.name,required this.picture,required this.children,required this.goods});

        
        
        
        // 2. 编写工厂函数
        factory CategoryItem.fromJson(Map<String,dynamic> json){
          return CategoryItem(
            id: json['id'] ?? "",//这里是从json 内取数据  ?? 是空判定
            name: json['name'] ?? "",//这里是从json 内取数据
            picture: json['picture'] ?? "",//这里是从json 内取数据
            children: (json['children'] as List<dynamic>?)
              ?.map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
              .toList() ?? [], // 判断为空并转换子分类列表
            goods: json['goods'] ?? [],//这里是从json 内取数据
          );
        }
      }
      
      class GoodsItem {
        String? id;
        String? name;
        String? picture;
        double? price;
        GoodsItem({required this.id,required this.name,required this.picture,required this.price});
      }

      // 特惠推荐相关模型类
      class SpecialOfferResult {
        String? id;
        String? title;
        List<SpecialOfferSubType>? subTypes;
        SpecialOfferResult({required this.id, required this.title, required this.subTypes});

        factory SpecialOfferResult.fromJson(Map<String, dynamic> json) {
          return SpecialOfferResult(
            id: json['id'] ?? "",
            title: json['title'] ?? "",
            subTypes: (json['subTypes'] as List<dynamic>?)
                ?.map((e) => SpecialOfferSubType.fromJson(e as Map<String, dynamic>))
                .toList() ?? [],
          );
        }
      }

      class SpecialOfferSubType {
        String? id;
        String? title;
        SpecialOfferGoodsItems? goodsItems;
        SpecialOfferSubType({required this.id, required this.title, required this.goodsItems});

        factory SpecialOfferSubType.fromJson(Map<String, dynamic> json) {
          return SpecialOfferSubType(
            id: json['id'] ?? "",
            title: json['title'] ?? "",
            goodsItems: json['goodsItems'] != null
                ? SpecialOfferGoodsItems.fromJson(json['goodsItems'] as Map<String, dynamic>)
                : null,
          );
        }
      }

      class SpecialOfferGoodsItems {
        int? counts;
        int? pageSize;
        int? pages;
        int? page;
        List<SpecialOfferGoodsItem>? items;
        SpecialOfferGoodsItems({required this.counts, required this.pageSize, required this.pages, required this.page, required this.items});

        factory SpecialOfferGoodsItems.fromJson(Map<String, dynamic> json) {
          return SpecialOfferGoodsItems(
            counts: json['counts'] ?? 0,
            pageSize: json['pageSize'] ?? 0,
            pages: json['pages'] ?? 0,
            page: json['page'] ?? 0,
            items: (json['items'] as List<dynamic>?)
                ?.map((e) => SpecialOfferGoodsItem.fromJson(e as Map<String, dynamic>))
                .toList() ?? [],
          );
        }
      }

      class SpecialOfferGoodsItem {
        String? id;
        String? name;
        String? desc;
        double? price;
        String? picture;
        int? orderNum;
        SpecialOfferGoodsItem({required this.id, required this.name, this.desc, required this.price, required this.picture, required this.orderNum});

        factory SpecialOfferGoodsItem.fromJson(Map<String, dynamic> json) {
          return SpecialOfferGoodsItem(
            id: json['id'] ?? "",
            name: json['name'] ?? "",
            desc: json['desc'],
            price: double.tryParse(json['price'] ?? "0") ?? 0.0,
            picture: json['picture'] ?? "",
            orderNum: json['orderNum'] ?? 0,
          );
        }
      }
      


