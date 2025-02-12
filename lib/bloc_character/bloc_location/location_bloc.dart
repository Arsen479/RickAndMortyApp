import 'package:bloc/bloc.dart';
import 'package:flutter_rick_and_morty/models/location_model.dart';
import 'package:flutter_rick_and_morty/repository/repository.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    Repository repository = Repository();
    List<ResultLocation>? allLocation = [];
    int currentPage = 1;
    bool hasMorePage = true;
    bool endPage = false;

    on<GetLocation>((event, emit) async {
      emit(LocationLoading());

      try {
        allLocation = await repository.getAllLocation(currentPage) ?? [];
        hasMorePage = allLocation!.isNotEmpty;

        emit(LocationLoaded(locations: allLocation ?? []));
      } catch (e) {
        emit(LocationError(e.toString()));
      }
    });

    on<GetMoreLocation>((event, emit) async {
      if (endPage) return;

      try {
        currentPage++;
        final newLocation = await repository.getAllLocation(currentPage);

        if (newLocation == null) {
          endPage = true;
          emit(LocationLoaded(locations: allLocation ?? [], endPage: endPage));
        } else {
          allLocation?.addAll(newLocation);
          emit(LocationLoaded(locations: allLocation ?? [], endPage: endPage));
        }
      } catch (e) {
        emit(LocationError(e.toString()));
      }
    });
  }
}
