import 'package:get/get.dart';

class Product{
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? imageUrl;
  final int? quantity;
  final Rating? rating;

  Product({this.id, this.title, this.description, this.category ,this.imageUrl, this.quantity ,this.rating, this.price});

  factory Product.fromJson(Map data){
    Rating r = Rating();
    if(data['rating'] != null){
      r = Rating.fromJson(data['rating']);
    }
    return Product(
      id: data['id'],
      title: data['title'],
      price: double.parse(data['price'] == null ? "0": data['price'].toString()),
      category: data['category'],
      description: data['description'],
      imageUrl: data['image'],
      rating: r
    );
  }
}

class Rating{
  final double? rating;
  final int? count;

  Rating({this.rating, this.count});

  factory Rating.fromJson(Map data){
    return Rating(
      rating: data['rating'],
      count: data['count'],
    );
  }
}