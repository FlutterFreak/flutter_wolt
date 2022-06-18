import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wolt_assignment/core/common/loader_animation.dart';
import 'package:flutter_wolt_assignment/domain/entity/restaurant_info.dart';
import 'package:flutter_wolt_assignment/presentation/bloc/location_list_bloc.dart';

class RestaurantTile extends StatelessWidget {
  final RestaurantInfo info;
  const RestaurantTile({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        dense: false,
        key: Key(info.id!),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            info.url!,
            width: 80,
            height: 150,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return const CustomLoader();
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.image,
              );
            },
            fit: BoxFit.fill,
          ),
        ),
        title: Text(info.name!),
        subtitle: Text(
          info.shortDescription!,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: false,
        trailing: GestureDetector(
          onTap: () {
            if (info.isFavorite!) {
              context.read<LocationListBloc>().removeFavorite(info.id!);
            } else {
              context.read<LocationListBloc>().addFavorite(info.id!);
            }
          },
          child: info.isFavorite!
              ? const Icon(Icons.favorite_sharp)
              : const Icon(Icons.favorite_outline_sharp),
        ),
      ),
    );
  }
}
