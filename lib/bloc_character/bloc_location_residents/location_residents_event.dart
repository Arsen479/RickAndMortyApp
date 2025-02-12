part of 'location_residents_bloc.dart';

@immutable
sealed class LocationResidentsEvent {}

class GetLocationResidents extends LocationResidentsEvent{
  final List<String> locationResidentsUrl;

  GetLocationResidents(this.locationResidentsUrl);
}
