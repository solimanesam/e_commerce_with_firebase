import 'package:e_commerce_with_firebase/core/services/cache_service.dart';
import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/getcoffee_cubit.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          DashboardCubit controller = context.read<DashboardCubit>();
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.notifications)),
                PopupMenuButton(
                  itemBuilder: (context) => List.empty(),
                ),
              ],
              backgroundColor: AppColors.primaryColor,
              title: FutureBuilder<String?>(
                future: Future.delayed(
                  const Duration(milliseconds: 500),
                  () =>
                      getIt<BaseCacheService>().getStringFromCache(key: "name"),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      'Loading...',
                      style: TextStyles.regular14_120(context),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text(
                      'Error',
                      style: TextStyles.regular14_120(context),
                    );
                  }
                  final name = snapshot.data ?? "Guest";
                  return Text(
                    'Good day, $name',
                    style: TextStyles.regular14_120(context),
                  );
                },
              ),
              leading:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ),
            body: PageView(
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.onPageChanged(index);
              },
              children: [
                BlocProvider(
                  create: (context) => GetcoffeeCubit(getIt()),
                  child: HomePage(),
                ),
                Center(child: Text('2')),
                Center(child: Text('3')),
                Center(child: Text('4')),
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
