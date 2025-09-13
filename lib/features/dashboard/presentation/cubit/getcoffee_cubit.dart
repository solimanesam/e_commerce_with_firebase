import 'package:bloc/bloc.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/coffee_entity.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/repos/admin_base_repo.dart';
import 'package:equatable/equatable.dart';

part 'getcoffee_state.dart';

class GetcoffeeCubit extends Cubit<GetcoffeeState> {
  GetcoffeeCubit(this.adminBaseRepo) : super(GetcoffeeInitial());
  final AdminBaseRepo adminBaseRepo;
  List<CoffeeEntity> coffees = [];
  getcoffee({required GetKindCoffee getKindCoffee}) async {
    emit(GetcoffeeLoading());
    final result = await adminBaseRepo.getAllCoffees();
    result.fold((l) => emit(GetcoffeeFailure(l.message)), (r) {
      switch (getKindCoffee) {
        case GetKindCoffee.popular:
          coffees = r;
          break;
        case GetKindCoffee.blackCoffee:
          coffees =
              r.where((element) => element.kind == "Black coffee").toList();
          break;
        case GetKindCoffee.winterSpecial:
          coffees =
              r.where((element) => element.kind == "Winter special").toList();
          break;
        case GetKindCoffee.decaffee:
          coffees = r.where((element) => element.kind == "Decaffe").toList();
          break;
      }
      emit(GetcoffeeSuccess(coffees));
    });
  }
}

enum GetKindCoffee { popular, blackCoffee, winterSpecial, decaffee }
