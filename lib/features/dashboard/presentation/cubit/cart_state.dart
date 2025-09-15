import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/order_entity.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<OrderItem> cartItems;

  CartLoaded({required this.cartItems});

  @override
  List<Object?> get props => [cartItems];
}

class CartError extends CartState {
  final String message;
  CartError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CartSuccess extends CartState {
  final String? message;
  CartSuccess({this.message});

  @override
  List<Object?> get props => [message];
}

class CartLoading extends CartState {}
