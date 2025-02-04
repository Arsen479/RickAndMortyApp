part of 'rick_and_morty_bloc.dart';

@immutable
sealed class RickAndMortyState {}

final class RickAndMortyInitial extends RickAndMortyState {}

final class RickAndMortyLoadingState extends RickAndMortyState {}

final class RickAndMortyLoadedState extends RickAndMortyState {
  final List<Result> characters;

  RickAndMortyLoadedState({required this.characters});
}

final class RickAndMortyErrorState extends RickAndMortyState {
  final String error;

  RickAndMortyErrorState(this.error);
}
