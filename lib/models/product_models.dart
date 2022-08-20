class Products {
  final id;
  final title;
  final price;
  final image;

  const Products({this.id, this.title, this.price, this.image});

  factory Products.fromJson(Map<String, dynamic> json) => Products(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      image: json['image']);
}
