part of 'characters_in_episode_bloc.dart';

@immutable
sealed class CharactersInEpisodeEvent {}

class GetCharactersEpisode extends CharactersInEpisodeEvent{
  final List<String> charactersEpisodeUrl;

  GetCharactersEpisode(this.charactersEpisodeUrl);
}
