import 'package:bloc/bloc.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/order_entity.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/repos/admin_base_repo.dart';
import 'package:equatable/equatable.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.adminBaseRepo) : super(OrdersInitial());
  final AdminBaseRepo adminBaseRepo;
  getAllOrders() async {
    emit(OrdersLoading());
    final result = await adminBaseRepo.getAllOrders();
    result.fold(
      (l) {
        emit(OrdersFailure(message: l.message));
      },
      (r) {
        emit(OrdersLoaded(orders: r));
      },
    );
  }

  updateStatus({required String orderId, required String status}) async {
    final result =
        await adminBaseRepo.updateOrderStatus(orderId: orderId, status: status);
    result.fold((l) {
      emit(OrdersFailure(message: l.message));
    }, (r) {
      getAllOrders();
      print('updated status successfully');
    });
  }
}
