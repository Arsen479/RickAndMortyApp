part of 'location_residents_bloc.dart';

@immutable
sealed class LocationResidentsState {}

final class LocationResidentsInitial extends LocationResidentsState {}

final class LocationResidentsLoading extends LocationResidentsState{}

final class LocationResidentsLoaded extends LocationResidentsState{
  final List<Result> residents;

  LocationResidentsLoaded(this.residents);
}

final class LocationResidentsError extends LocationResidentsState{
  final String error;

  LocationResidentsError(this.error);
}
