part of 'orders_user_cubit.dart';

sealed class OrdersUserState extends Equatable {
  const OrdersUserState();

  @override
  List<Object> get props => [];
}

final class OrdersUserInitial extends OrdersUserState {}

final class OrdersUserLoading extends OrdersUserState {}

final class OrdersUserFailure extends OrdersUserState {
  final String message;
  const OrdersUserFailure({required this.message});
}

final class OrdersUserLoaded extends OrdersUserState {
  final List<OrderModel> orders;
  const OrdersUserLoaded({required this.orders});
}

final class PlaceOrderSuccess extends OrdersUserState {}
