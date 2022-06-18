import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/core/common/coordinates.dart';

void main() {
  test('Coordinates instance equality', () {
    var data = Coordinates(0, 0);
    expect(data.props.length, 2);
  });
}
