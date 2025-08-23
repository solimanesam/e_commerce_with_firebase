part of 'admin_dashboard_cubit.dart';

sealed class AdminDashboardState extends Equatable {
  const AdminDashboardState();

  @override
  List<Object> get props => [];
}

final class AdminDashboardInitial extends AdminDashboardState {}

final class AdminDashboardLoading extends AdminDashboardState {}

final class AdminDashboardLoaded extends AdminDashboardState {
  final List<CoffeeEntity> coffees;
  const AdminDashboardLoaded({required this.coffees});
}

final class AdminDashboardFailure extends AdminDashboardState {
  final String message;
  const AdminDashboardFailure({required this.message});
}
