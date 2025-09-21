import 'package:e_commerce_with_firebase/core/services/cache_service.dart';
import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/getcoffee_cubit.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/pages/cart_page.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/pages/home_page.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/pages/orders_page.dart';
import 'package:e_commerce_with_firebase/features/shared/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ValueNotifier<String> nameNotifier =
      ValueNotifier<String>("Loading...");
  late final String? userId;
  @override
  void initState() {
    super.initState();
    _loadName();
    userId = getIt<BaseCacheService>().getStringFromCache(key: "uId");
  }

  Future<void> _loadName() async {
    final cachedName =
        getIt<BaseCacheService>().getStringFromCache(key: "name");
    nameNotifier.value = cachedName ?? "Guest";
  }

  @override
  void dispose() {
    nameNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          DashboardCubit controller = context.read<DashboardCubit>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              title: ValueListenableBuilder<String>(
                valueListenable: nameNotifier,
                builder: (context, name, _) {
                  return Text(
                    "Good day, $name",
                    style: TextStyles.regular14_120(context),
                  );
                },
              ),
            ),
            body: PageView(
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.onPageChanged(index);
              },
              children: [
                BlocProvider(
                  create: (context) => GetcoffeeCubit(getIt()),
                  child: const HomePage(),
                ),
                BlocProvider(
                  create: (context) => CartCubit(cartBaseRepo: getIt()),
                  child: CartPage(userId: userId!),
                ),
                OrdersPage(
                  userId: userId!,
                ),
                SettingsPage(),
              ],
            ),
            bottomNavigationBar: ClipRRect(
              child: BottomNavigationBar(
                iconSize: 35,
                backgroundColor: AppColors.primaryColor,
                selectedItemColor: AppColors.secondryColor,
                unselectedItemColor: AppColors.secondryColor,
                currentIndex: controller.selectedTapIndex,
                onTap: (index) {
                  controller.onChangeTabIndex(index);
                },
                items: controller.bottomNavigationBarItems,
                type: BottomNavigationBarType.fixed,
              ),
            ),
          );
        },
      ),
    );
  }
}
