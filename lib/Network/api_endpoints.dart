enum Environment { testing, production }
class ApiEndpoints
{

  //base end urls
  static const _baseUrl = "https://fakestoreapi.com";
  static const _childUrl = "/";
  static const apiBaeUrl = "$_baseUrl$_childUrl";

  //api end points

  //authentication
  static const login = "auth/login";
  static const signup = "users";
  static const updateProfile = "users";
  static const getUserProfile = "users";
  static const addToCart = "carts";
  static const removeFromCart = "carts";
  static const getUserCart = "carts/user";
  static const getAllProducts = "products";
  static const getAllCategories = "products/categories";



}