part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

class GetLocation extends LocationEvent {}

class GetMoreLocation extends LocationEvent {}
