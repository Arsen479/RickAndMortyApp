import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_rick_and_morty/models/character_model.dart';
import 'package:flutter_rick_and_morty/models/location_model.dart';
import 'package:flutter_rick_and_morty/repository/repository.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'location_residents_event.dart';
part 'location_residents_state.dart';

class LocationResidentsBloc
    extends Bloc<LocationResidentsEvent, LocationResidentsState> {
  LocationResidentsBloc() : super(LocationResidentsInitial()) {
    Repository repository = Repository();

    on<GetLocationResidents>((event, emit) async {
      try {
        emit(LocationResidentsLoading());

        final List<Result> residents =
            await repository.getResidentLocation(event.locationResidentsUrl);

        log('Residents ${residents.toString()}');

        emit(LocationResidentsLoaded(residents));
      } catch (error) {
        emit(LocationResidentsError(error.toString()));
      }
    });
  }
}
