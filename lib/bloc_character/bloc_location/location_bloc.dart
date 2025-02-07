import 'package:bloc/bloc.dart';
import 'package:flutter_rick_and_morty/models/location_model.dart';
import 'package:flutter_rick_and_morty/repository/repository.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    Repository repository = Repository();

    on<GetLocation>((event, emit) async {
      emit(LocationLoading());

      try {
        List<ResultLocation> locationModel = await repository.getAllLocation();

        emit(LocationLoaded(locationModel));
      } catch (e) {
        emit(LocationError(e.toString()));
      }
    });
  }
}
