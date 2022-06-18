import 'package:equatable/equatable.dart';
import 'package:flutter_wolt_assignment/core/constants/strings.dart';

class RestaurantsByLocation with EquatableMixin {
  List<Sections>? sections;

  RestaurantsByLocation({
    this.sections,
  });

  @override
  List<Object?> get props => [sections];

  RestaurantsByLocation.fromJson(
    Map<String, dynamic> json,
  ) {
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
  }
}

class Sections with EquatableMixin {
  List<Items>? items;
  String? name;
  String? title;

  Sections({this.items, this.name, this.title});

  @override
  List<Object?> get props => [name, title, items];

  Sections.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? AppStrings.emptyString;
    title = json['title'] ?? AppStrings.emptyString;
    if (json['items'] != null) {
      items = <Items>[];

      json['items'].asMap().forEach((index, value) {
        if (index > 14) {
          return;
        }
        items!.add(Items.fromJson(value));
      });
    }
  }
}

class Items with EquatableMixin {
  Image? image;
  Venue? venue;

  Items({
    this.image,
    this.venue,
  });

  @override
  List<Object?> get props => [image, venue];

  Items.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
  }
}

class Image with EquatableMixin {
  String? url;

  Image({
    this.url,
  });

  @override
  List<Object?> get props => [url];

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'] ?? AppStrings.emptyString;
  }
}

class Venue with EquatableMixin {
  String? id;
  String? name;
  String? shortDescription;

  Venue({
    this.id,
    this.name,
    this.shortDescription,
  });

  @override
  List<Object?> get props => [id, name, shortDescription];

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? AppStrings.emptyString;
    name = json['name'] ?? AppStrings.emptyString;
    shortDescription = json['short_description'] ?? AppStrings.emptyString;
  }
}
