import 'package:bloc/bloc.dart';
import 'package:flutter_rick_and_morty/models/character_model.dart';
import 'package:flutter_rick_and_morty/models/episode_model.dart';
import 'package:flutter_rick_and_morty/repository/repository.dart';
import 'package:meta/meta.dart';

part 'character_episode_event.dart';
part 'character_episode_state.dart';

class CharacterEpisodeBloc
    extends Bloc<CharacterEpisodeEvent, CharacterEpisodeState> {
  CharacterEpisodeBloc() : super(CharacterEpisodeInitial()) {
    Repository repository = Repository();

    on<GetCharacterEpisode>((event, emit) async {
      emit(CharacterEpisodeLoading());

      try {
        final List<Results> episodes =
            await repository.getEpisodes(event.episodeUrl);
        emit(CharacterEpisodeLoaded(episodes));
      } catch (e) {
        emit(CharacterEpisodeError(e.toString()));
      }
    });
  }
}
