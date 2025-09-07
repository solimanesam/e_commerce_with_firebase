import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_snake_bar.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/controllers/cubit/admin_dashboard_cubit.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/view/component/admin_product_widget.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/view/pages/admin_add_page.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/view/pages/admin_update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Products extends StatelessWidget {
  const Products({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdminDashboardCubit(adminBaseRepo: getIt())..getAllCoffee(),
      child: BlocListener<AdminDashboardCubit, AdminDashboardState>(
        listener: (context, state) {
          if (state is AdminDashboardSuccess) {
            showCustomSnackBar(context,
                message: 'Coffee Deleted', type: SnackBarType.success);
            context.read<AdminDashboardCubit>().getAllCoffee();
          } else if (state is AdminDashboardFailure) {
            showCustomSnackBar(context,
                message: state.message, type: SnackBarType.failure);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.secondryColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (context) =>
                        AdminDashboardCubit(adminBaseRepo: getIt()),
                    child: AdminAddPage(),
                  ),
                ),
              );
            },
            child: Icon(
              Icons.add,
              color: AppColors.primaryColor,
            ),
          ),
          body: BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
            builder: (context, state) {
              if (state is AdminDashboardLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondryColor,
                  ),
                );
              } else if (state is AdminDashboardLoaded) {
                if (state.coffees.isEmpty) {
                  return Center(
                    child: Text(
                      'No coffees',
                      style: TextStyles.semiBold20(context),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: state.coffees.length,
                    itemBuilder: (context, index) {
                      return adminproductWidget(
                        context: context,
                        coffeeKind: state.coffees[index].kind,
                        coffeeName: state.coffees[index].name,
                        image: state.coffees[index].imageUrl,
                        price: state.coffees[index].price.toString(),
                        onEdit: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                        create: (context) =>
                                            AdminDashboardCubit(
                                          adminBaseRepo: getIt(),
                                        ),
                                        child: AdminUpdatePage(
                                          coffee: state.coffees[index],
                                        ),
                                      )));
                        },
                        onDelete: () {
                          context
                              .read<AdminDashboardCubit>()
                              .deleteCoffee(coffeeId: state.coffees[index].id!);
                        },
                      );
                    },
                  );
                }
              } else if (state is AdminDashboardFailure) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyles.semiBold20(
                      context,
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
