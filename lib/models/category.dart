class Category {
  int? catID;
  String? catName;

  Category({this.catID, this.catName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(catID: json['catID'], catName: json['catName']);
  }

  Map<String, dynamic> toJson() {
    return {'catID': catID, 'catName': catName};
  }
}
