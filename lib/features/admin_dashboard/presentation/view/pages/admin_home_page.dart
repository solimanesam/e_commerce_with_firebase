import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/controllers/cubit/admin_dashboard_cubit.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/view/component/admin_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdminDashboardCubit(adminBaseRepo: getIt())..getAllCoffee(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            'Admin Dashboard',
            style: TextStyles.semiBold20(
              context,
            ),
          ),
          shape: Border(
              bottom: BorderSide(color: AppColors.secondryColor, width: 1)),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondryColor,
          onPressed: () {
            Navigator.pushNamed(context, 'adminadd');
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
                      onEdit: () {},
                      onDelete: () {},
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
    );
  }
}
