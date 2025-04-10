import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form/Api+Bloc/characterRepo.dart';
import 'package:form/Api+Bloc/stateManagement/event.dart';
import 'package:form/Api+Bloc/stateManagement/state.dart';


class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository repository;

  CharacterBloc(this.repository) : super(CharacterInitial()) {
    on<LoadCharacters>((event, emit) async {
      emit(CharacterLoading());
      try {
        final characters = await repository.fetchCharacters();
        emit(CharacterLoaded(characters));
      } catch (e) {
        emit(CharacterError("Failed to load characters"));
      }
    });
  }
}
