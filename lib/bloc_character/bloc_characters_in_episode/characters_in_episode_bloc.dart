import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_rick_and_morty/models/character_model.dart';
import 'package:flutter_rick_and_morty/models/episode_model.dart';
import 'package:flutter_rick_and_morty/repository/repository.dart';
import 'package:meta/meta.dart';

part 'characters_in_episode_event.dart';
part 'characters_in_episode_state.dart';

class CharactersInEpisodeBloc extends Bloc<CharactersInEpisodeEvent, CharactersInEpisodeState> {
  CharactersInEpisodeBloc() : super(CharactersInEpisodeInitial()) {
    Repository repository = Repository();

    on<GetCharactersEpisode>((event, emit) async{
      try {
        emit(CharactersInEpisodeLoading());

        final List<Result> charactersInEpisode = await repository.getCharactersInEpisode(event.charactersEpisodeUrl);

        log(charactersInEpisode.toString());

        emit(CharactersInEpisodeLoaded(charactersInEpisode: charactersInEpisode));
      } catch (error) {
        emit(CharactersInEpisodeError(error: error.toString()));
      }
    });
  }
}
