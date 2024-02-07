import 'package:fake_commerce_app/Models/cart_item.dart';

import '/Models/product.dart';
import '/Network/api_endpoints.dart';
import '/Network/api_provider.dart';
import 'package:get/get.dart';
import '../Constants/pref_data.dart';
import '../Models/user_model.dart';

class CartController extends GetxController{
 final ApiProvider _apiProvider = ApiProvider();
  List<CartItem> _cartItems = [];
  List<Product> _products = [];
  List<Product> _cartProducts = [];
  bool loading = false;
  double _total = 0;
  double _discount = 0;
  double _coupon= 0;
  double _payable= 0;

  List<CartItem> get cartItems => _cartItems;
  List<Product> get cartProducts => _cartProducts;
  double get total => _total;
  double get discount => _discount;
  double get coupon => _coupon;
  double get payable => _payable;

  @override
  void onInit() async{
    await _getAllProducts();
    await getAllCartItems();
    super.onInit();
  }

 _getAllProducts()async{
   loading = true;
   update();
   dynamic res = await _apiProvider.get(url: ApiEndpoints.getAllProducts, body: {});
   if(res != null){
     if(res.statusCode == 200){
       List x = res.data;
       _products = x.map((e) => Product.fromJson(e)).toList();
       update();
     }
   }
   loading = false;
   update();
 }

  getAllCartItems() async{
    String userId = await PrefData.getUserId();
    if(userId.isNotEmpty) {
      loading = true;
      update();
      dynamic res = await _apiProvider.get(url: "${ApiEndpoints.getUserCart}/$userId", body: {});
      if(res != null){
        if(res.statusCode == 200){
          var data = res.data;
          List x = data;
          _cartItems.clear();
          _cartProducts.clear();
          for(var i in x){
           Map item = i;
           List<Product> items = [];
           List g = item['products'];
           for(var p in g){
            List<Product> pro = _products.where((element) => element.id.toString() == p['productId'].toString()).toList();
            if(pro.isNotEmpty){
              Product product = Product(
                id: pro.first.id,
                title: pro.first.title,
                description: pro.first.description,
                category: pro.first.category,
                imageUrl: pro.first.imageUrl,
                quantity: p['quantity'],
                rating: pro.first.rating,
                price: pro.first.price
              );
              _cartProducts.add(product);
              items.add(product);
            }
           }

           _cartItems.add(CartItem.fromJson(item, items));
          }
          update();
          _calculateBill();
        }
      }
    }
    print("cart Products : ${_cartProducts.length}");
    loading = false;
    update();
  }


  _calculateBill()async{
    _total = 0;
    for(var i in _cartProducts){
      _total += (i.price ?? 0) * (i.quantity ?? 1);
    }
    _payable = _total;
    update();
  }

   bool _isAlreadyAdded(String bookId){
      int count = 0;
      for(var b in _cartItems){
        if(b.id.toString() == bookId){
          count++;
        }
      }
      return count > 0;
    }

    clearCart(){
      _cartItems.clear();
      _calculateBill();
      update();
    }

}