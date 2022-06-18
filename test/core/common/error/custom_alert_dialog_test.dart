import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/core/common/error/custom_alert_dialog.dart';
import 'package:flutter_wolt_assignment/core/constants/strings.dart';

import '../../../flutter_test_utilities.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Custom alert dialog  test', (tester) async {
    await tester.runAsync(() async {
      await buildAndPumpWidget(
          CustomAlertDialog(
              title: AppStrings.noInternetHeader,
              message: AppStrings.noInternet,
              okBtnText: AppStrings.okButtonLabel,
              onOkPressed: () {}),
          tester);
      await tester.pump(const Duration(milliseconds: 10));
      expect(find.byType(CustomAlertDialog), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 10));
      expect(find.text(AppStrings.noInternetHeader), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 10));
      expect(find.text(AppStrings.noInternet), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 10));
      await tester.tap(find.text(AppStrings.okButtonLabel));
    });
  });
}
