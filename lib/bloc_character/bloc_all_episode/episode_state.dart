part of 'episode_bloc.dart';

@immutable
sealed class EpisodeState {}

final class EpisodeInitial extends EpisodeState {}

final class EpisodeLoading extends EpisodeState {}

final class EpisodeLoaded extends EpisodeState {
  final Map<String, List<Results>> episodes;

  EpisodeLoaded(this.episodes);
}

final class EpisodeError extends EpisodeState {
  final String error;

  EpisodeError(this.error);
}