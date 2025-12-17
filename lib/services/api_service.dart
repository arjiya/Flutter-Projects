import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"),
  );

  Future<List<dynamic>> getPosts() async {
    try {
      Response response = await _dio.get("/posts");
      return response.data;
    } catch (e) {
      print("Error fetching posts: $e");
      return [];
    }
  }
}
