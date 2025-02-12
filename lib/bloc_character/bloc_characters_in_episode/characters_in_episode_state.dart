part of 'characters_in_episode_bloc.dart';

@immutable
sealed class CharactersInEpisodeState {}

final class CharactersInEpisodeInitial extends CharactersInEpisodeState {}

final class CharactersInEpisodeLoading extends CharactersInEpisodeState {}

final class CharactersInEpisodeLoaded extends CharactersInEpisodeState {
  final List<Result> charactersInEpisode;

  CharactersInEpisodeLoaded({required this.charactersInEpisode});
}

final class CharactersInEpisodeError extends CharactersInEpisodeState {
  final String error;

  CharactersInEpisodeError({required this.error});
}
