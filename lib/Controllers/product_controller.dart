import 'package:fake_commerce_app/Models/category_products.dart';
import 'package:fake_commerce_app/Network/api_endpoints.dart';
import 'package:get/get.dart';
import '../Models/product.dart';
import '../Network/api_provider.dart';

class ProductController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();
  List<Product> _products = [];
  List<CategoryProducts> _categoryProducts = [];
  List<String> _categories = [];
  bool loading = false;
  Product _selectedProduct = Product();

  List<Product> get products => _products;
  List<CategoryProducts> get categoryProducts => _categoryProducts;
  Product get selectedProduct => _selectedProduct;

  set selectedProduct(Product val){
    _selectedProduct = val;
    update();
  }

  @override
  void onInit() {
    _getAllCategories();
    getAllProducts();
    super.onInit();
  }

  getAllProducts()async{
    loading = true;
    update();
    _categoryProducts.clear();
    dynamic res = await _apiProvider.get(url: ApiEndpoints.getAllProducts, body: {});
    if(res != null){
      if(res.statusCode == 200){
        List x = res.data;
        _products = x.map((e) => Product.fromJson(e)).toList();
        for(String cat in _categories){
          List<Product> p = _products.where((element) => element.category == cat).toList();
          var c = CategoryProducts(
            category: cat,
            products: p
          );
          _categoryProducts.add(c);
        }
        print("Categories : ${_categories.length}");
        print("Categories Products : ${_categoryProducts.length}");
        update();
      }
    }
    loading = false;
    update();
  }

  _getAllCategories() async{
    loading = true;
    update();
    dynamic res = await _apiProvider.get(url: ApiEndpoints.getAllCategories, body: {});
    if(res != null){
      if(res.statusCode == 200){
        List x = res.data;
        _categories = x.map<String>((e) => e).toList();
        update();
      }
    }
    loading = false;
    update();
  }
}


