import 'package:equatable/equatable.dart';

class Coordinates with EquatableMixin {
  final double lat;
  final double long;

  Coordinates(this.lat, this.long);

  @override
  List<Object?> get props => [lat, long];
}
