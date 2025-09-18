import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/widgts/app_loading_overlay.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_show_alert_dialog.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_snake_bar.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/coffee_model.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/cart_state.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/orders_user_cubit.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/components/cart_item_widget.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/components/checkout_container.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/components/remove_from_cart_bottom_sheet.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  final String userId;

  const CartPage({super.key, required this.userId});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartCubit cartCubit;

  @override
  void initState() {
    super.initState();
    cartCubit = context.read<CartCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartCubit.getCartItems(userId: widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondryColor,
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartSuccess) {
            showCustomSnackBar(
              context,
              message: state.message ?? 'Processed',
              type: SnackBarType.success,
            );
          } else if (state is CartError) {
            showCustomSnackBar(
              context,
              message: state.message,
              type: SnackBarType.failure,
            );
          }
        },
        builder: (context, state) {
          return AppLoadingOverlay(
            isLoading: state is CartLoading,
            child: Builder(
              builder: (context) {
                if (state is CartError) {
                  return Center(child: Text("❌ ${state.message}"));
                } else if (state is CartLoaded) {
                  final items = state.cartItems;

                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        "Cart is empty 🛒",
                        style: TextStyles.semiBold32(
                          context,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }

                  double totalPrice = items.fold(
                    0,
                    (sum, item) => sum + (item.coffee.price * item.quantity),
                  );

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "My Cart",
                            style: TextStyles.semiBold32(
                              context,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showCustomAlertDialog(
                                context: context,
                                title: 'Clear My Cart',
                                message:
                                    'Are you sure you want to clear your cart?',
                                onConfirm: () =>
                                    cartCubit.clearCart(userId: widget.userId),
                              );
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              color: AppColors.primaryColor,
                            ),
                            iconSize: 30,
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: items.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return CartItemWidget(
                              item: item,
                              userId: widget.userId,
                              removeFromCart: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  builder: (_) {
                                    return RemoveFromCartBottomSheet(
                                      item: item,
                                      onRemove: (qty) {
                                        cartCubit.removeFromCart(
                                          userId: widget.userId,
                                          coffee: CoffeeModel(
                                            id: item.coffee.id,
                                            name: item.coffee.name,
                                            kind: item.coffee.kind,
                                            price: item.coffee.price,
                                            imageUrl: item.coffee.imageUrl,
                                          ),
                                          quantity: qty,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      BlocProvider(
                        create: (context) => OrdersUserCubit(getIt()),
                        child: ChectOutContainer(
                          cubit: cartCubit,
                          totalPrice: totalPrice,
                          userId: widget.userId,
                          items: items,
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
