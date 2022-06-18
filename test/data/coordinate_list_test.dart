import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/data/coordinate_list.dart';

void main() {
  test('Coordinate list test', () {
    var list = coordinateList;
    expect(list.length, 10);
    expect(list[0].lat, 60.170187);
    expect(list[0].long, 24.930599);
  });
}
