import 'package:bloc/bloc.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/coffee_model.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/coffee_entity.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/repos/admin_base_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'admin_dashboard_state.dart';

class AdminDashboardCubit extends Cubit<AdminDashboardState> {
  AdminDashboardCubit({required this.adminBaseRepo})
      : super(AdminDashboardInitial());
  final AdminBaseRepo adminBaseRepo;
////////////////////get
  getAllCoffee() async {
    emit(AdminDashboardLoading());
    final result = await adminBaseRepo.getAllCoffees();
    result.fold((l) {
      emit(AdminDashboardFailure(message: l.message));
    }, (r) {
      emit(AdminDashboardLoaded(coffees: r));
    });
  }

  ///////////////////////add
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  String? selectedKind;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  clearControllers() {
    nameController.clear();
    priceController.clear();
    imageUrlController.clear();
  }

  addcoffee() async {
    if (formKey.currentState!.validate()) {
      emit(AdminDashboardLoading());
      final result = await adminBaseRepo.addCoffee(
          coffee: CoffeeModel(
              name: nameController.text,
              kind: selectedKind!,
              price: double.parse(priceController.text),
              imageUrl: imageUrlController.text));
      result.fold((l) {
        emit(AdminDashboardFailure(message: l.message));
      }, (r) {
        print('success');
        emit(AdminDashboardSuccess());
      });
    }
  }

  ///////////////delete
  deleteCoffee({required String coffeeId}) async {
    emit(AdminDashboardLoading());
    final result = await adminBaseRepo.deleteCoffee(coffeeId: coffeeId);
    result.fold((l) {
      emit(AdminDashboardFailure(message: l.message));
    }, (r) {
      print('success');
      emit(AdminDashboardSuccess());
    });
  }
}
