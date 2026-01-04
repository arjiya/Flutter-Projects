import 'package:bloc/bloc.dart';
import '../services/api_service.dart';
import 'product_state.dart'; 
class ProductCubit extends Cubit<ProductState> {
  final ApiService apiService;

  ProductCubit(this.apiService) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final products = await apiService.getProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(const ProductError("Unable to load products"));
    }
  }
 Future<void> fetchProductById(int id) async {
  emit(ProductLoading());
  try {
    final products = await apiService.getProducts();
    final product = products.firstWhere((p) => p.id == id);
    emit(ProductLoaded([product]));
  } catch (e) {
    emit(const ProductError("Unable to load product"));
  }
}
 
}


