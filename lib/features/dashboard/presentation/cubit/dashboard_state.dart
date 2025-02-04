part of 'dashboard_cubit.dart';

 class DashboardState extends Equatable {
  final int selectedTapIndex ;
  const DashboardState({ this.selectedTapIndex = 0});

  @override
  List<Object> get props => [selectedTapIndex];
}

