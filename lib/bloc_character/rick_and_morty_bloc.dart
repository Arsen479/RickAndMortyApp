import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_rick_and_morty/models/character_model.dart';
import 'package:flutter_rick_and_morty/repository/repository.dart';
import 'package:meta/meta.dart';

part 'rick_and_morty_event.dart';
part 'rick_and_morty_state.dart';

class RickAndMortyBloc extends Bloc<RickAndMortyEvent, RickAndMortyState> {
  RickAndMortyBloc() : super(RickAndMortyInitial()) {
    Repository repository = Repository();
    List<Result> allCharacters = [];
    int currentPage = 1;
    bool hasMorePage = true;

    on<GetAllCharacter>((event, emit) async {
      try {
        emit(RickAndMortyLoadingState());

        currentPage = 1;
        //List<Result> characterModel = await repository.getAllCharacter(currentPage);
        allCharacters = await repository.getAllCharacter(currentPage);
        hasMorePage = allCharacters.isNotEmpty;

        log('All Character: ${allCharacters.toString()}');

        emit(RickAndMortyLoadedState(characters: allCharacters));
      } catch (e) {
        emit(RickAndMortyErrorState(e.toString()));
      }
    });

    on<GetMoreCharacters>((event, emit) async {
      if (!hasMorePage) return;

      try {
        currentPage++;
        final newCharacters = await repository.getAllCharacter(currentPage);

        if (newCharacters.isEmpty) {
          hasMorePage = false;
        } else {
          allCharacters.addAll(newCharacters);
          emit(RickAndMortyLoadedState(characters: allCharacters));
        }
      } catch (e) {
        emit(RickAndMortyErrorState(e.toString()));
      }
    });
  }
}
