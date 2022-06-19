import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/presentation/bloc/location_list_bloc.dart';

import 'domain/repository/api_repository_test.mocks.dart';
import 'mocks/mock_data.dart';

Widget getMaterialWrapper(Widget child) {
  return MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
    ),
    themeMode: ThemeMode.dark,
    home: Material(child: child),
  );
}

Future<void> buildAndPump(
  Widget page,
  MockApiRepo repository,
  WidgetTester tester,
) async {
  final app = BlocProvider(
    create: (context) => LocationListBloc(repository),
    child: getMaterialWrapper(page),
  );
  await tester.pumpWidget(app);
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

Future<void> buildAndPumpWidget(
  Widget child,
  WidgetTester tester,
) async {
  final app = getMaterialWrapper(child);
  await tester.pumpWidget(app);
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

DioError dioError({int? statusCode, String? error, DioErrorType? type}) {
  return DioError(
    requestOptions: requestOptions,
    type: type!,
    error: error,
    response: Response(
        requestOptions: requestOptions,
        statusCode: statusCode,
        data: {"msg": error}),
  );
}
