import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/order-list/cubit/order_list_cubit.dart';
import '../features/register-product/cubit/register_product_cubit.dart';

class AppBlocProviders {
  static List<BlocProvider> getProviders() {
    return [
      BlocProvider<OrderListCubit>(
        create: (context) => OrderListCubit(),
      ),
      BlocProvider<RegisterProductCubit>(
        create: (context) => RegisterProductCubit(),
      ),
    ];
  }
}