import 'package:e_commerce_with_firebase/core/models/custom_button_input_model.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_snake_bar.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/order_model.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/order_entity.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/orders_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChectOutContainer extends StatelessWidget {
  const ChectOutContainer({
    super.key,
    required this.totalPrice,
    required this.userId,
    required this.items,
    required this.cubit,
  });
  final CartCubit cubit;
  final double totalPrice;
  final String userId;
  final List<OrderItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:",
                style: TextStyles.semiBold18(
                  context,
                ),
              ),
              Text(
                "${totalPrice.toStringAsFixed(2)} EGP",
                style: TextStyles.semiBold18(
                  context,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
              width: double.infinity,
              child: BlocConsumer<OrdersUserCubit, OrdersUserState>(
                listener: (context, state) {
                  if (state is OrdersUserFailure) {
                    showCustomSnackBar(context,
                        message: state.message, type: SnackBarType.failure);
                  } else if (state is PlaceOrderSuccess) {
                    showCustomSnackBar(context,
                        message: 'Order Placed', type: SnackBarType.success);
                    cubit.clearCart(userId: userId);
                    Navigator.pushNamed(
                      context,
                      'orderConfirmation',
                    );
                  }
                },
                builder: (context, state) {
                  return customButton(
                      customButtonInputModel: CustomButtonInputModel(
                          context: context,
                          text: state is OrdersUserLoading
                              ? 'Loading...'
                              : 'Checkout',
                          onPressed: state is OrdersUserLoading
                              ? null
                              : () {
                                  context.read<OrdersUserCubit>().placeOrder(
                                        order: OrderModel(
                                            userId: userId, items: items),
                                      );
                                },
                          color: AppColors.primaryColor,
                          textColor: AppColors.secondryColor));
                },
              )),
        ],
      ),
    );
  }
}
