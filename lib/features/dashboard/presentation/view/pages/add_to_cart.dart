import 'package:e_commerce_with_firebase/core/services/cache_service.dart';
import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/widgts/app_loading_overlay.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_snake_bar.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/coffee_model.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/coffee_entity.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/cart_state.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/components/add_to_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCart extends StatefulWidget {
  final CoffeeEntity coffee;

  const AddToCart({super.key, required this.coffee});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  final ValueNotifier<int> quantityNotifier = ValueNotifier<int>(1);
  final ValueNotifier<bool> loadingNotifier = ValueNotifier<bool>(false);
  late final String? uId;
  @override
  void initState() {
    uId = getIt<BaseCacheService>().getStringFromCache(key: "uId");
    super.initState();
  }

  @override
  void dispose() {
    quantityNotifier.dispose();
    loadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartSuccess) {
          loadingNotifier.value = false;

          final qty = quantityNotifier.value;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${widget.coffee.name} added to cart ($qty)"),
            ),
          );
          Navigator.of(context).pop();
        } else if (state is CartError) {
          loadingNotifier.value = false;

          showCustomSnackBar(context,
              message: state.message, type: SnackBarType.failure);
        } else if (state is CartLoading) {
          loadingNotifier.value = true;
        }
      },
      child: ValueListenableBuilder(
          valueListenable: loadingNotifier,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.secondryColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: AppColors.primaryColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
              shape: Border(
                  bottom: BorderSide(color: AppColors.primaryColor, width: 1)),
              title: Text(
                "Add to Cart",
                style: TextStyles.semiBold20(context)
                    .copyWith(color: AppColors.primaryColor),
              ),
              centerTitle: true,
            ),
            backgroundColor: AppColors.secondryColor,
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // ☕ صورة الكوفي
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.coffee.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 📝 الاسم + النوع
                  Text(
                    widget.coffee.name,
                    style: TextStyles.semiBold20(
                      context,
                    ).copyWith(color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.coffee.kind,
                    style: TextStyles.regular16_120(
                      context,
                    ).copyWith(color: AppColors.primaryColor),
                  ),

                  const SizedBox(height: 25),

                  // 💵 السعر + زرار الكمية
                  quantityWidget(),

                  const Spacer(),

                  // 🛒 زرار Add to Cart
                  AddToCartButton(
                    coffee: widget.coffee,
                    onPressed: () {
                      cubit.addToCart(
                          quantity: quantityNotifier.value,
                          userId: uId ?? '',
                          coffee: CoffeeModel(
                              name: widget.coffee.name,
                              kind: widget.coffee.kind,
                              price: widget.coffee.price,
                              imageUrl: widget.coffee.imageUrl));
                    },
                  ),
                ],
              ),
            ),
          ),
          builder: (context, value, child) {
            return AppLoadingOverlay(
              isLoading: loadingNotifier.value,
              child: child!,
            );
          }),
    );
  }

  ValueListenableBuilder<int> quantityWidget() {
    return ValueListenableBuilder<int>(
      valueListenable: quantityNotifier,
      builder: (context, quantity, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${(widget.coffee.price * quantity).toStringAsFixed(2)}EGP",
              style:
                  TextStyles.semiBold32(context, color: AppColors.primaryColor),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle,
                      color: AppColors.primaryColor),
                  onPressed: () {
                    if (quantity > 1) {
                      quantityNotifier.value = quantity - 1;
                    }
                  },
                ),
                Text(
                  quantity.toString(),
                  style: TextStyles.semiBold20(
                    context,
                  ).copyWith(color: AppColors.primaryColor),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle,
                      color: AppColors.primaryColor),
                  onPressed: () => quantityNotifier.value = quantity + 1,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
