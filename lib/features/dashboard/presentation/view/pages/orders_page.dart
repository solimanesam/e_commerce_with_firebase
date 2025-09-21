import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/widgts/app_loading_overlay.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_snake_bar.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/orders_user_cubit.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/components/user_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrdersUserCubit(getIt())..getUserOrders(userId: userId),
      child: Column(
        children: [
          Text(
            'My Orders',
            style:
                TextStyles.semiBold32(context, color: AppColors.secondryColor),
          ),
          Expanded(
            child: BlocBuilder<OrdersUserCubit, OrdersUserState>(
              builder: (context, state) {
                return AppLoadingOverlay(
                  isLoading: state is OrdersUserLoading,
                  child: () {
                    if (state is OrdersUserFailure) {
                      showCustomSnackBar(
                        context,
                        message: state.message,
                        type: SnackBarType.failure,
                      );
                      return const Center(child: Text("Failed to load orders"));
                    } else if (state is OrdersUserLoaded) {
                      if (state.orders.isEmpty) {
                        return const Center(child: Text("No orders found"));
                      }
                      return ListView.builder(
                        itemCount: state.orders.length,
                        itemBuilder: (context, index) {
                          final order = state.orders[index];

                          return UserOrderCard(order: order);
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
