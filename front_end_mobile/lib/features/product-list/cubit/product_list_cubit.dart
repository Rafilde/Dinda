import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_mobile/features/product-list/services/product_list_services.dart';
import 'package:front_end_mobile/shared/locator.dart';
import 'package:front_end_mobile/shared/models/product_model.dart';

part 'product_list_state.dart';
class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(const InitialProductListState());

  Future<void> getListOfProducts() async {
    emit(const LoadingProductListState());

    try {
      final productList = await Locator.instance.get<ProductListServices>().fetchProducts();

      final products = productList.map((data) => ProductModel.fromJson(data)).toList();

      emit(SuccessProductListState(products: products));
    } catch (e) {
      emit(ErrorProductListState('Erro ao buscar produtos: $e'));
    }
  }
}
