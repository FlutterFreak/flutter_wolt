import 'package:equatable/equatable.dart';

class RestaurantInfo with EquatableMixin {
  final String? id;
  final String? name;
  final String? shortDescription;
  final String? url;
  final bool? isFavorite;

  RestaurantInfo(
      {this.id, this.name, this.shortDescription, this.url, this.isFavorite});

  @override
  List<Object?> get props => [id, name, shortDescription, url, isFavorite];

  RestaurantInfo copyWith({bool? isFavorite}) {
    return RestaurantInfo(
        id: id,
        name: name,
        shortDescription: shortDescription,
        url: url,
        isFavorite: isFavorite);
  }
}
