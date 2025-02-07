import 'package:bloc/bloc.dart';
import 'package:flutter_rick_and_morty/models/episode_model.dart';
import 'package:flutter_rick_and_morty/repository/repository.dart';
import 'package:meta/meta.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  EpisodeBloc() : super(EpisodeInitial()) {
    Repository repository = Repository();

    on<GetALLEpisode>((event, emit) async {
      try {
        emit(EpisodeLoading());

        Map<String, List<Results>> episodes =
            await repository.getAllEpisodes();

        emit(EpisodeLoaded(episodes));
      } catch (e) {
        emit(EpisodeError(e.toString()));
      }
    });
  }
}
