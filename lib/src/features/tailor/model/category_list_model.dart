import 'dart:convert';

class TailorCategoryListRes {
  bool? status;
  dynamic message;
  List<Category>? categories;

  TailorCategoryListRes({
    this.status,
    this.message,
    this.categories,
  });

  factory TailorCategoryListRes.fromJson(String str) => TailorCategoryListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TailorCategoryListRes.fromMap(Map<String, dynamic> json) => TailorCategoryListRes(
    status: json["status"],
    message: json["message"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toMap())),
  };
}

class Category {
  int? id;
  dynamic catName;
  List<PatternCategory>? patternCategories;

  Category({
    this.id,
    this.catName,
    this.patternCategories,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    catName: json["cat_name"],
    patternCategories: json["pattern_categories"] == null ? [] : List<PatternCategory>.from(json["pattern_categories"]!.map((x) => PatternCategory.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "cat_name": catName,
    "pattern_categories": patternCategories == null ? [] : List<dynamic>.from(patternCategories!.map((x) => x.toMap())),
  };
}

class PatternCategory {
  int? id;
  dynamic catName;
  int? catId;
  List<PatternFiltercategory>? patternFiltercategories;

  PatternCategory({
    this.id,
    this.catName,
    this.catId,
    this.patternFiltercategories,
  });

  factory PatternCategory.fromJson(String str) => PatternCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PatternCategory.fromMap(Map<String, dynamic> json) => PatternCategory(
    id: json["id"],
    catName: json["cat_name"],
    catId: json["cat_id"],
    patternFiltercategories: json["pattern_filtercategories"] == null ? [] : List<PatternFiltercategory>.from(json["pattern_filtercategories"]!.map((x) => PatternFiltercategory.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "cat_name": catName,
    "cat_id": catId,
    "pattern_filtercategories": patternFiltercategories == null ? [] : List<dynamic>.from(patternFiltercategories!.map((x) => x.toMap())),
  };
}

class PatternFiltercategory {
  int? id;
  int? patternCategoriesId;
  dynamic image;
  dynamic name;
  dynamic price;

  PatternFiltercategory({
    this.id,
    this.patternCategoriesId,
    this.image,
    this.name,
    this.price,
  });

  factory PatternFiltercategory.fromJson(String str) => PatternFiltercategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PatternFiltercategory.fromMap(Map<String, dynamic> json) => PatternFiltercategory(
    id: json["id"],
    patternCategoriesId: json["pattern_categories_id"],
    image: json["image"],
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "pattern_categories_id": patternCategoriesId,
    "image": image,
    "name": name,
    "price": price,
  };
}
