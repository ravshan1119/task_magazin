class ProductsModelFields {
  static const String id = "_id";
  static const String productId = "product_id";
  static const String title = "title";
  static const String price = "price";
  static const String description = "description";
  static const String category = "category";
  static const String image = "image";
  static const String rate = "rate";
  static const String rateCount = "rate_count";
  static const String count = "count";

  static const String productsTable = "products";
}

class ProductModelSql {
  int? id;
  int idProduct;
  String title;
  double price;
  String description;
  String category;
  String image;
  double rate;
  int rateCount;
  int count;

  ProductModelSql({
    this.id,
    required this.idProduct,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.rateCount,
    required this.count,
  });

  ProductModelSql copyWith({
    int? idProduct,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    double? rate,
    int? rateCount,
    int? id,
    int? count,
  }) =>
      ProductModelSql(
        idProduct: idProduct ?? this.idProduct,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        category: category ?? this.category,
        image: image ?? this.image,
        rate: rate ?? this.rate,
        rateCount: rateCount ?? this.rateCount,
        id: id ?? this.id,
        count: count ?? this.count,
      );

  factory ProductModelSql.fromJson(Map<String, dynamic> json) =>
      ProductModelSql(
        id: json[ProductsModelFields.id],
        idProduct: json[ProductsModelFields.productId],
        title: json[ProductsModelFields.title],
        price: json[ProductsModelFields.price],
        description: json[ProductsModelFields.description],
        category: json[ProductsModelFields.category],
        image: json[ProductsModelFields.image],
        rate: json[ProductsModelFields.rate],
        rateCount: json[ProductsModelFields.rateCount],
        count: json[ProductsModelFields.count],
      );

  Map<String, dynamic> toJson() => {
        ProductsModelFields.id: id,
        ProductsModelFields.productId: idProduct,
        ProductsModelFields.title: title,
        ProductsModelFields.price: price,
        ProductsModelFields.description: description,
        ProductsModelFields.category: category,
        ProductsModelFields.image: image,
        ProductsModelFields.rate: rate,
        ProductsModelFields.rateCount: rateCount,
        ProductsModelFields.count: count,
      };
}
