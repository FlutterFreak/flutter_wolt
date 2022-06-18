import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mock_data.dart';

void main() {
  test('Restaurant info entity', () async {
    var entity = restaurantInfo;
    expect(entity.name, "McDonald's Helsinki Kamppi");
    expect(entity.props.length, 5);
  });
}
