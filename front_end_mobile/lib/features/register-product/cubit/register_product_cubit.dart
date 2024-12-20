import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_mobile/shared/locator.dart';
import '../services/register_product_services.dart';
part 'register_product_state.dart';

class RegisterProductCubit extends Cubit<RegisterProductState> {
  RegisterProductCubit() : super(const InitialRegisterProductState());

  Future<void> createProduct(String name, String price, int quantity, List<String> imageUrl) async {
    if (state is InitialRegisterProductState) emit(const LoadingRegisterProductState());
    try {
      await Locator.instance.get<RegisterProductServices>().createProduct(name, price, quantity, imageUrl);
      emit(const SuccessRegisterProductState());
    } catch (e) {
      debugPrint('Error while saving product: $e');
      emit(ErrorRegisterProductState(e.toString()));
    }
  }
}