import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/core/common/error/custom_alert_dialog.dart';
import 'package:flutter_wolt_assignment/core/common/error/error_popup_view_model.dart';
import 'package:flutter_wolt_assignment/core/constants/strings.dart';
import 'package:flutter_wolt_assignment/presentation/view/home.dart';
import 'package:flutter_wolt_assignment/presentation/widgets/restaurant_tile.dart';
import 'package:mockito/mockito.dart';

import '../../domain/repository/api_repository_test.mocks.dart';
import '../../flutter_test_utilities.dart';
import '../../mocks/mock_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final repository = MockApiRepo();

  setUp(() {
    when(repository.getRestaurantsList(any, any))
        .thenAnswer((_) async => Left(restaurantsByLocationModel));
  });

  testWidgets('Populate Screen with a list of 15 values', (tester) async {
    await buildAndPump(const Home(), repository, tester);
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.byType(Home), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.byType(ListView), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.byType(RestaurantTile), findsNWidgets(15));
    await tester.tap(find.byType(RestaurantTile).first);
    await tester.pumpAndSettle();
  });

  testWidgets('Error dialog test when no internet', (tester) async {
    when(repository.getRestaurantsList(any, any))
        .thenAnswer((_) async => Right(ErrorPopupViewModel.noInternet()));

    await buildAndPump(const Home(), repository, tester);
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.byType(Home), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.byType(CustomAlertDialog), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text(AppStrings.noInternetHeader), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text(AppStrings.noInternet), findsOneWidget);
  });
}
