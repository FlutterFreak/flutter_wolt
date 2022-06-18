import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wolt_assignment/presentation/viewModel/restaurants_list_view_model.dart';
import 'package:flutter_wolt_assignment/presentation/widgets/restaurant_tile.dart';

import '../../core/common/utils.dart';
import '../bloc/location_list_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationListBloc, LocationListState>(
        bloc: context.read<LocationListBloc>()..getRestaurantsList(),
        listenWhen: (previous, current) =>
            previous.error.title.isEmpty && current.error.title.isNotEmpty,
        listener: (context, state) {
          Utils.showErrorPopup(context, state.error);
        },
        buildWhen: (previous, current) =>
            previous.loader.isLoading == true &&
            current.loader.isLoading == false,
        builder: (context, state) {
          if (state.loader.isLoading == true) {
            return Utils.showLoader();
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Restaurants List"),
            ),
            body: Builder(builder: (context) {
              return BlocSelector<LocationListBloc, LocationListState,
                  RestaurantsListViewModel>(
                selector: (state) => state.data,
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: ListView.builder(
                      itemCount: state.restaurantsList!.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return RestaurantTile(
                            info: state.restaurantsList![index]);
                      },
                    ),
                  );
                },
              );
            }),
          );
        });
  }
}
