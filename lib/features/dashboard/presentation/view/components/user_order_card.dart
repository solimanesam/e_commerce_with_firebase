import 'package:flutter/material.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/order_entity.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';

class UserOrderCard extends StatelessWidget {
  final OrderEntity order;

  const UserOrderCard({super.key, required this.order});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "approved":
        return AppColors.secondryColor; // لون مميز للقبول
      case "pending":
        return AppColors.orangeDesignColor;
      case "rejected":
        return Colors.red; // ممكن تعرف لون رفض مخصص لو عايز
      default:
        return AppColors.greyDesignColor;
    }
  }

  String shortId(String? id) {
    if (id == null) return "N/A";
    return id.length > 8 ? id.substring(0, 8) : id;
  }

  String _getStatusMessage(String status) {
    switch (status.toLowerCase()) {
      case "accepted":
      case "approved":
        return "✅ Your order has been accepted and will be prepared soon.";
      case "pending":
        return "⏳ Your order is under review.";
      case "rejected":
        return "❌ Your order was rejected. Please try again or choose another product.";
      default:
        return "📌 Unknown order status.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightDesinColor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Header
            Text(
              "Order #${shortId(order.id)}...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.secondryColor,
              ),
            ),
            const SizedBox(height: 8),

            // ✅ Order items
            Column(
              children: order.items.map((item) {
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
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondryColor,
                    ),
                  ),
                  subtitle: Text(
                    "Type: ${item.coffee.kind}",
                    style: TextStyle(color: AppColors.greyDesignColor),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "x${item.quantity}",
                        style: TextStyle(color: AppColors.greyDesignColor),
                      ),
                      Text(
                        "${item.coffee.price} EGP",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.orangeDesignColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Divider(color: AppColors.activeGreyDesignColor),

            // ✅ Status message
            Text(
              _getStatusMessage(order.status),
              style: TextStyle(
                color: _getStatusColor(order.status),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
