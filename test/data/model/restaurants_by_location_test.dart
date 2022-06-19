import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/Data/Model/restaurants_by_location.dart';

import '../../mocks/fixture_reader.dart';

void main() {
  /// mocking json
  Map<String, dynamic> jsonResponse = json.decode(fixture('json_data.json'));

  test('RestaurantsByLocation Response', () async {
    // Given
    RestaurantsByLocation response =
        RestaurantsByLocation.fromJson(jsonResponse);

    // Model validation.
    expect(response.props.length, 1);
    expect(response.sections!.length, 2);
  });

  test('Sections', () async {
    // Given
    Sections response = Sections.fromJson(jsonResponse['sections'][1]);

    // Model validation.
    expect(response.props.length, 3);
    expect(response.title, "All restaurants");
    expect(response.name, "restaurants-delivering-venues");
    expect(response.items!.length, 15);
  });

  test('Items response', () async {
    // Given
    Items response = Items.fromJson(jsonResponse['sections'][1]['items'][0]);

    // Model validation.
    expect(response.props.length, 2);
    expect(
        response.image,
        Image(
            url:
                "https://prod-wolt-venue-images-cdn.wolt.com/5ae6013cf78b5a000bb64022/bc80c9c4-9ead-11eb-9441-4efedaea1730_mcd_wolt_etusivu_1010x544.png"));
    expect(
        response.venue,
        Venue(
            id: "5ae6013cf78b5a000bb64022",
            name: "McDonald's Helsinki Kamppi",
            shortDescription: "I'm lovin' it."));
  });
  test('Image response', () async {
    // Given
    Image response =
        Image.fromJson(jsonResponse['sections'][1]['items'][0]["image"]);

    // Model validation.
    expect(response.props.length, 1);
    expect(response.url,
        "https://prod-wolt-venue-images-cdn.wolt.com/5ae6013cf78b5a000bb64022/bc80c9c4-9ead-11eb-9441-4efedaea1730_mcd_wolt_etusivu_1010x544.png");
  });
  test('Venue response', () async {
    // Given
    Venue response =
        Venue.fromJson(jsonResponse['sections'][1]['items'][0]["venue"]);

    // Model validation.
    expect(response.props.length, 3);
    expect(response.id, "5ae6013cf78b5a000bb64022");
    expect(response.name, "McDonald's Helsinki Kamppi");
    expect(response.shortDescription, "I'm lovin' it.");
  });
}
