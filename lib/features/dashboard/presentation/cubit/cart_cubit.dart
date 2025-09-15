import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/coffee_model.dart';
import 'package:e_commerce_with_firebase/features/dashboard/domain/repos/cart_base_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.cartBaseRepo}) : super(CartInitial());
  final CartBaseRepo cartBaseRepo;

  Future<void> getCartItems({required String userId}) async {
    emit(CartLoading());
    final result = await cartBaseRepo.getCartItems(userId: userId);
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (cartItems) => emit(CartLoaded(cartItems: cartItems)),
    );
  }

  Future<void> addToCart({
    required String userId,
    required CoffeeModel coffee,
    int quantity = 1,
  }) async {
    emit(CartLoading());
    final result = await cartBaseRepo.addToCart(
        userId: userId, coffee: coffee, quantity: quantity);
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (_) {
        emit(CartSuccess(message: "تمت الإضافة بنجاح"));
      },
    );
  }

  Future<void> removeFromCart({
    required String userId,
    required CoffeeModel coffee,
    int quantity = 1,
  }) async {
    emit(CartLoading());
    final result = await cartBaseRepo.removeFromCart(
        userId: userId, coffee: coffee, quantity: quantity);
    result.fold(
      (failure) {
        print(failure.message);
        emit(CartError(message: failure.message));
      },
      (_) {
        print("success");
        emit(CartSuccess(message: "تم الحذف بنجاح"));
        getCartItems(userId: userId);
      },
    );
  }

  Future<void> clearCart({required String userId}) async {
    emit(CartLoading());
    final result = await cartBaseRepo.clearCart(userId: userId);
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (_) {
        emit(CartSuccess(message: "تم تفريغ السلة"));
        getCartItems(userId: userId);
      },
    );
  }
}
