import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/order_entity.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const OrderCard({
    super.key,
    required this.order,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = order.items.fold(
      0,
      (sum, item) => sum + (item.coffee.price * item.quantity),
    );

    return Card(
      color: AppColors.lightDesinColor,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order #${order.id.substring(0, 6)}...",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Chip(
                  label: Text(order.status),
                  backgroundColor: _statusColor(order.status),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text("User ID: ${order.userId}",
                style: Theme.of(context).textTheme.bodySmall),

            const Divider(height: 20),

            // Items
            Column(
              children: order.items.map((item) => _buildItem(item)).toList(),
            ),

            const SizedBox(height: 12),

            // Total Price
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Total: ${totalPrice.toStringAsFixed(2)}EGP",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Actions
            Visibility(
              visible: order.status == "pending",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: onReject,
                    icon: const Icon(Icons.close, color: Colors.red),
                    label: const Text("Reject"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: onApprove,
                    icon: const Icon(Icons.check),
                    label: const Text("Approve"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(OrderItem item) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          item.coffee.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
      ),
      title: Text(item.coffee.name),
      subtitle: Text("${item.coffee.kind} - Qty: ${item.quantity}"),
      trailing: Text(
        "${(item.coffee.price * item.quantity).toStringAsFixed(2)}EGP",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "approved":
        return Colors.green.shade100;
      case "rejected":
        return Colors.red.shade100;
      default:
        return AppColors.primaryColor;
    }
  }
}
