import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/getcoffee_cubit.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/components/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayUserCoffee extends StatefulWidget {
  const DisplayUserCoffee({super.key, required this.getKindCoffee});
  final GetKindCoffee getKindCoffee;
  @override
  State<DisplayUserCoffee> createState() => _DisplayUserCoffeeState();
}

class _DisplayUserCoffeeState extends State<DisplayUserCoffee> {
  @override
  void initState() {
    context
        .read<GetcoffeeCubit>()
        .getcoffee(getKindCoffee: widget.getKindCoffee);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetcoffeeCubit, GetcoffeeState>(
      builder: (context, state) {
        final cubit = context.read<GetcoffeeCubit>();
        if (state is GetcoffeeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetcoffeeFailure) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is GetcoffeeSuccess) {
          return cubit.coffees.isEmpty
              ? const Center(
                  child: Text('No Coffee From this kind'),
                )
              : ListView.builder(
                  itemCount: cubit.coffees.length,
                  itemBuilder: (context, index) {
                    return productWidgt(
                        context: context,
                        price: cubit.coffees[index].price.toString(),
                        coffeekind: cubit.coffees[index].kind,
                        coffeename: cubit.coffees[index].name,
                        image: cubit.coffees[index].imageUrl);
                  },
                );
        }
        return Container();
      },
    );
  }
}
