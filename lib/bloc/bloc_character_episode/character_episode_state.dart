part of 'character_episode_bloc.dart';

@immutable
sealed class CharacterEpisodeState {}

final class CharacterEpisodeInitial extends CharacterEpisodeState {}

final class CharacterEpisodeLoading extends CharacterEpisodeState {}

final class CharacterEpisodeLoaded extends CharacterEpisodeState {
  final List<Results> episodes;

  CharacterEpisodeLoaded(this.episodes);
}

final class CharacterEpisodeError extends CharacterEpisodeState {
  final String error;

  CharacterEpisodeError(this.error);
}
