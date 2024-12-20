part of 'register_product_cubit.dart';

class RegisterProductState {
  const RegisterProductState();
}

class InitialRegisterProductState extends RegisterProductState {
  const InitialRegisterProductState();
}

class LoadingRegisterProductState extends RegisterProductState {
  const LoadingRegisterProductState();
}

class SuccessRegisterProductState extends RegisterProductState {
  const SuccessRegisterProductState();
}

class ErrorRegisterProductState extends RegisterProductState {
  final String message;
  const ErrorRegisterProductState(this.message);
}
