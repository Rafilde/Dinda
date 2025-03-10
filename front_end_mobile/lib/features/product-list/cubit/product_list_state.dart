part of 'product_list_cubit.dart';

class ProductListState {
  const ProductListState();
}

class InitialProductListState extends ProductListState {
  const InitialProductListState();
}

class LoadingProductListState extends ProductListState {
  const LoadingProductListState();
}

class SuccessProductListState extends ProductListState {
  final List<ProductModel> products;
  const SuccessProductListState({required this.products});
}

class ErrorProductListState extends ProductListState {
  final String message;
  const ErrorProductListState(this.message);
}
