part of 'dashboard_cubit.dart';

 class DashboardState extends Equatable {
  final int selectedTapIndex ;
  const DashboardState({required this.selectedTapIndex});

  @override
  List<Object> get props => [selectedTapIndex];
}

