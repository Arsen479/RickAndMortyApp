part of 'character_episode_bloc.dart';

@immutable
sealed class CharacterEpisodeEvent {}

class GetCharacterEpisode extends CharacterEpisodeEvent {
  final List<String> episodeUrl;

  GetCharacterEpisode(this.episodeUrl);
}
