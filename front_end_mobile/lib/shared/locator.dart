import 'package:front_end_mobile/features/product-list/services/product_list_services.dart';
import 'package:get_it/get_it.dart';
import '../features/register-product/services/register_product_services.dart';

class Locator {
  static late GetIt _getIt;
  static GetIt get instance {
    _getIt = GetIt.instance;
    return _getIt;
  }

  Locator.setup() {
    _getIt = GetIt.instance;
    _getIt.registerSingleton<RegisterProductServices>(RegisterProductServices());
    _getIt.registerSingleton<ProductListServices>(ProductListServices());
  }
}