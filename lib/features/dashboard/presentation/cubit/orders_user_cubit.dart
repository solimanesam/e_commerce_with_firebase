import 'package:bloc/bloc.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/order_model.dart';
import 'package:e_commerce_with_firebase/features/dashboard/domain/repos/orders_base_repo.dart';
import 'package:equatable/equatable.dart';

part 'orders_user_state.dart';

class OrdersUserCubit extends Cubit<OrdersUserState> {
  OrdersUserCubit(this.ordersBaseRepo) : super(OrdersUserInitial());
  final OrdersBaseRepo ordersBaseRepo;

  placeOrder({required OrderModel order}) async {
    emit(OrdersUserLoading());
    final result = await ordersBaseRepo.placeOrder(orderModel: order);
    result.fold((failure) => emit(OrdersUserFailure(message: failure.message)),
        (_) => emit(PlaceOrderSuccess()));
  }

  getUserOrders({required String userId}) async {
    emit(OrdersUserLoading());
    final result = await ordersBaseRepo.getUserOrders(userId: userId);
    result.fold((failure) => emit(OrdersUserFailure(message: failure.message)),
        (orders) => emit(OrdersUserLoaded(orders: orders)));
  }
}
