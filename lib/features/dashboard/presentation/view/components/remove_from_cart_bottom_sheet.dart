import 'package:flutter/material.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/order_entity.dart';

class RemoveFromCartBottomSheet extends StatefulWidget {
  final OrderItem item;
  final void Function(int quantity) onRemove;

  const RemoveFromCartBottomSheet({
    super.key,
    required this.item,
    required this.onRemove,
  });

  @override
  State<RemoveFromCartBottomSheet> createState() =>
      _RemoveFromCartBottomSheetState();
}

class _RemoveFromCartBottomSheetState extends State<RemoveFromCartBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.secondryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Wrap(
        children: [
          // الشريط الصغير اللي فوق
          Center(
            child: Container(
              height: 5,
              width: 50,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          // اسم المنتج
          Text(
            "🛒 ${widget.item.coffee.name}",
            style: TextStyles.semiBold20(
              context,
            ).copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 10),

          // خيار: تقليل 1
          ListTile(
            leading: const Icon(Icons.remove_circle, color: Colors.orange),
            title: const Text("Remove 1 item",
                style: TextStyle(color: AppColors.primaryColor)),
            onTap: () {
              Navigator.pop(context);
              widget.onRemove(1);
            },
          ),

          // خيار: إدخال كمية مخصصة
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.blue),
            title: const Text("Remove custom quantity",
                style: TextStyle(color: AppColors.primaryColor)),
            subtitle: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: AppColors.primaryColor),
              decoration: const InputDecoration(
                hintText: "Enter quantity to remove",
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: () {
                final qty = int.tryParse(_controller.text) ?? 0;
                if (qty > 0) {
                  Navigator.pop(context);
                  widget.onRemove(qty);
                }
              },
            ),
          ),

          // خيار: حذف الكل
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: Text("Remove all (${widget.item.quantity})",
                style: const TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              widget.onRemove(widget.item.quantity);
            },
          ),
        ],
      ),
    );
  }
}
