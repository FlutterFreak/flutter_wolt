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
  });

  test('Sections', () async {
    // Given
    Sections response = Sections.fromJson(jsonResponse['sections'][1]);

    // Model validation.
    expect(response.props.length, 3);
  });

  test('Items response', () async {
    // Given
    Items response = Items.fromJson(jsonResponse['sections'][1]['items'][0]);

    // Model validation.
    expect(response.props.length, 2);
  });
  test('Image response', () async {
    // Given
    Image response =
        Image.fromJson(jsonResponse['sections'][1]['items'][0]["image"]);

    // Model validation.
    expect(response.props.length, 1);
  });
  test('Venue response', () async {
    // Given
    Venue response =
        Venue.fromJson(jsonResponse['sections'][1]['items'][0]["venue"]);

    // Model validation.
    expect(response.props.length, 3);
  });
}
