import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/controllers/cubit/orders_cubit.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/view/component/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Requests extends StatelessWidget {
  const Requests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit(getIt())..getAllOrders(),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OrdersLoaded) {
            return state.orders.isEmpty
                ? const Center(
                    child: Text('No requests'),
                  )
                : ListView.builder(
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      return OrderCard(
                        order: state.orders[index],
                        onApprove: () {
                          context.read<OrdersCubit>().updateStatus(
                              orderId: state.orders[index].id!,
                              status: 'approved');
                        },
                        onReject: () {
                          context.read<OrdersCubit>().updateStatus(
                              orderId: state.orders[index].id!,
                              status: 'rejected');
                        },
                      );
                    },
                  );
          } else if (state is OrdersFailure) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
