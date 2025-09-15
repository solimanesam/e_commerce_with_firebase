import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.item,
    required this.userId,
    required this.removeFromCart,
  });
  final Function() removeFromCart;
  final OrderItem item;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          item.coffee.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        item.coffee.name,
        style: TextStyles.semiBold16(
            color: AppColors.primaryColor, context: context),
      ),
      subtitle: Text(
        "${item.quantity} × ${item.coffee.price} EGP",
        style:
            TextStyles.regular14_150(context).copyWith(color: Colors.grey[600]),
      ),
      trailing: IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
          onPressed: removeFromCart),
    );
  }
}
