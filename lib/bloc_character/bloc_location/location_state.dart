part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationLoaded extends LocationState {
  final List<ResultLocation> locations;

  LocationLoaded(this.locations);
}

final class LocationError extends LocationState {
  final String error;

  LocationError(this.error);
}
