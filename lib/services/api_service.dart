import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../models/product_model.dart';


class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://fakestoreapi.com"));

  // Signup
  Future<bool> signup(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedEmailTemp', email);
    await prefs.setString('savedPasswordTemp', password);
    return true;
  }

  // Login
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('savedEmailTemp') ?? '';
    final savedPassword = prefs.getString('savedPasswordTemp') ?? '';
    return email == savedEmail && password == savedPassword;
  }

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get("/products");
      return (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } catch (e) {
      print("Error fetching products: $e");
      throw Exception("Failed to fetch products");
    }
  }
}