import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/presentation/widgets/restaurant_tile.dart';

import '../../domain/repository/api_repository_test.mocks.dart';
import '../../flutter_test_utilities.dart';
import '../../mocks/mock_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final repository = MockApiRepo();
  testWidgets('RestaurantInfo tile test', (tester) async {
    await tester.runAsync(() async {
      await buildAndPump(
          RestaurantTile(
            info: restaurantInfo,
          ),
          repository,
          tester);
      await tester.pump(const Duration(milliseconds: 10));
      expect(find.byType(RestaurantTile), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 10));
      expect(find.text("McDonald's Helsinki Kamppi"), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 10));
      expect(find.text("I'm lovin' it."), findsOneWidget);
    });
  });

  testWidgets('RestaurantInfo tile add favorite test', (tester) async {
    await tester.runAsync(() async {
      await buildAndPump(
          RestaurantTile(
            info: restaurantInfo,
          ),
          repository,
          tester);
      await tester.pump(const Duration(milliseconds: 10));
      expect(find.byIcon(Icons.favorite_outline_sharp), findsOneWidget);
      await tester.tap(find.byIcon(Icons.favorite_outline_sharp));
    });
  });

  testWidgets('RestaurantInfo tile remove favorite test', (tester) async {
    restaurantInfo = restaurantInfo.copyWith(isFavorite: true);
    await tester.runAsync(() async {
      await buildAndPump(
          RestaurantTile(
            info: restaurantInfo,
          ),
          repository,
          tester);
      await tester.pump(const Duration(milliseconds: 10));
      expect(find.byIcon(Icons.favorite_sharp), findsOneWidget);
      await tester.tap(find.byIcon(Icons.favorite_sharp));
    });
  });
}
