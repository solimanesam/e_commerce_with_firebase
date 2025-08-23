import 'package:bloc/bloc.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/coffee_entity.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/repos/admin_base_repo.dart';
import 'package:equatable/equatable.dart';

part 'admin_dashboard_state.dart';

class AdminDashboardCubit extends Cubit<AdminDashboardState> {
  AdminDashboardCubit({required this.adminBaseRepo})
      : super(AdminDashboardInitial());
  final AdminBaseRepo adminBaseRepo;

  getAllCoffee() async {
    emit(AdminDashboardLoading());
    final result = await adminBaseRepo.getAllCoffees();
    result.fold((l) {
      emit(AdminDashboardFailure(message: l.message));
    }, (r) {
    
      emit(AdminDashboardLoaded(coffees: r));
    });
  }
}
