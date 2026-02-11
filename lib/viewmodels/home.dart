class BannerItem {
  String? id;
  String? imgUrl;
  BannerItem({required this.id, required this.imgUrl});

  //扩展一个工厂函数  一般用factory 来声明 一般用来创建实例对象
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: json['id'] ?? "", //这里是从json 内取数据  ?? 是空判定
      imgUrl: json['imgUrl'] ?? "", //这里是从json 内取数据
    );
  }
} //每一个轮播图的具体类型

//根据json编写class对象和工厂转化函数
// 1. 编写class对象
class CategoryItem {
  String? id;
  String? name;
  String? picture;
  List<CategoryItem>? children;
  // List<GoodsItem>? goods;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    required this.children,
    // required this.goods,
  });

  // 2. 编写工厂函数
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'] ?? "", //这里是从json 内取数据  ?? 是空判定
      name: json['name'] ?? "", //这里是从json 内取数据
      picture: json['picture'] ?? "", //这里是从json 内取数据
      children:
          (json['children'] as List<dynamic>?)
              ?.map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [], // 判断为空并转换子分类列表
      // goods: json['goods'] ?? [], //这里是从json 内取数据
    );
  }
}



// 特惠推荐相关模型类
class SpecialOfferResult {
  String? id;
  String? title;
  List<SpecialOfferSubType>? subTypes;
  SpecialOfferResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory SpecialOfferResult.fromJson(Map<String, dynamic> json) {
    return SpecialOfferResult(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      subTypes:
          (json['subTypes'] as List<dynamic>?)
              ?.map(
                (e) => SpecialOfferSubType.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}

class SpecialOfferSubType {
  String? id;
  String? title;
  SpecialOfferGoodsItems? goodsItems;
  SpecialOfferSubType({
    required this.id,
    required this.title,
    required this.goodsItems,
  });

  factory SpecialOfferSubType.fromJson(Map<String, dynamic> json) {
    return SpecialOfferSubType(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      goodsItems: json['goodsItems'] != null
          ? SpecialOfferGoodsItems.fromJson(
              json['goodsItems'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

//goodsItems类型
class SpecialOfferGoodsItems {
  int? counts;
  int? pageSize;
  int? pages;
  int? page;
  List<SpecialOfferGoodsItem>? items;
  SpecialOfferGoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory SpecialOfferGoodsItems.fromJson(Map<String, dynamic> json) {
    return SpecialOfferGoodsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 0,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) =>
                    SpecialOfferGoodsItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}

class SpecialOfferGoodsItem {
  String? id;
  String? name;
  String? desc;
  String? price;
  String? picture;
  int? orderNum;
  SpecialOfferGoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory SpecialOfferGoodsItem.fromJson(Map<String, dynamic> json) {
    return SpecialOfferGoodsItem(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      desc: json['desc'],
      price: json["price"]?.toString() ?? "",
      picture: json['picture'] ?? "",
      orderNum: json['orderNum'] ?? 0,
    );
  }
}
//更多商品列表
class GoodDetailItem extends SpecialOfferGoodsItem {
  int payCount = 0;
  /// 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  // 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}

/////------------------覆写？？
///
///
/////goodsItems类型
class GoodsDetailsItems {
  int? counts;
  int? pageSize;
  int? pages;
  int? page;
  List<GoodDetailItem>? items;
  GoodsDetailsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

//复制 SpecialOfferGoodsItems 并 改名
  factory GoodsDetailsItems.fromJson(Map<String, dynamic> json) {
    return GoodsDetailsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 0,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) =>
                    GoodDetailItem.formJSON(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}



// 生成对应的class
class UserInfo {
  String account;
  String avatar;
  String birthday;
  String cityCode;
  String gender;
  String id;
  String mobile;
  String nickname;
  String profession;
  String provinceCode;
  String token;

  UserInfo({
    required this.account,
    required this.avatar,
    required this.birthday,
    required this.cityCode,
    required this.gender,
    required this.id,
    required this.mobile,
    required this.nickname,
    required this.profession,
    required this.provinceCode,
    required this.token,
  });

  factory UserInfo.fromJSON(Map<String, dynamic> json) => UserInfo(
    account: json["account"] ?? "",
    avatar: json["avatar"] ?? "",
    birthday: json["birthday"] ?? "",
    cityCode: json["cityCode"] ?? "",
    gender: json["gender"] ?? "",
    id: json["id"] ?? "",
    mobile: json["mobile"] ?? "",
    nickname: json["nickname"] ?? "",
    profession: json["profession"] ?? "",
    provinceCode: json["provinceCode"] ?? "",
    token: json["token"] ?? "",
  );
}
