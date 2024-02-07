import 'package:intl/intl.dart';
import 'product.dart';

class CartItem{
  final int? id;
  final int? userId;
  final DateTime? date;
  final List<Product>? products;

  CartItem({this.id ,this.userId, this.date, this.products});

  factory CartItem.fromJson(Map data, List<Product> productsList){
    return CartItem(
      id: data['id'],
      userId: data['userId'],
      date: DateTime.parse(data['date'] == null ? DateTime.now().toString() : data['date'].toString()),
      products: productsList
    );
  }

  toJson(){
    Map items = {};
    if(products != null){
      for(var p in products!){
        items['productId'] = p.id;
        items['quantity'] = p.quantity;
      }
      return  {
        "userId": userId,
        "date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
        "products": items
      };
    }
  }
}