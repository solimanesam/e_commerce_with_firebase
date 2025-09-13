part of 'getcoffee_cubit.dart';

sealed class GetcoffeeState extends Equatable {
  const GetcoffeeState();

  @override
  List<Object> get props => [];
}

final class GetcoffeeInitial extends GetcoffeeState {}

final class GetcoffeeLoading extends GetcoffeeState {}

final class GetcoffeeSuccess extends GetcoffeeState {
  final List<CoffeeEntity> coffees;
  const GetcoffeeSuccess(this.coffees);
}

final class GetcoffeeFailure extends GetcoffeeState {
  final String message;
  const GetcoffeeFailure(this.message);
}
