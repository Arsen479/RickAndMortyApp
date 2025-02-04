part of 'rick_and_morty_bloc.dart';

@immutable
sealed class RickAndMortyEvent {}

final class GetAllCharacter extends RickAndMortyEvent {}

final class GetCharacterByName extends RickAndMortyEvent {
  final String name;

  GetCharacterByName(this.name);
}

final class GetMoreCharacters extends RickAndMortyEvent {}

