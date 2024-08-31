import 'package:prueba_pragma/blocs/cat_information_event.dart';
import 'package:prueba_pragma/blocs/cat_information_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_pragma/models/cat_information.dart';
import 'package:prueba_pragma/repositories/cat_information_repository.dart';
import 'package:prueba_pragma/utilities/strings.dart';

class CatInformationBloc
    extends Bloc<CatInformationEvent, CatInformationState> {
  final CatInformationRepository repository;
  List<CatInformation> catInformationList = [];

  CatInformationBloc(this.repository) : super(CatInformationInitial()) {
    on<FetchCatInformation>(_onFetchCatInformation);
    on<FilterCatInformationByName>(_onFilterCatInformationByName);
  }

  void _onFetchCatInformation(
      FetchCatInformation event, Emitter<CatInformationState> emit) async {
    emit(CatInformationLoading());
    try {
      final catInfotmationFetchList = await repository.getCatsInformation();
      catInformationList = catInfotmationFetchList;
      emit(CatInformationLoaded(catInfotmationFetchList));
    } catch (e) {
      emit(CatInformationError(failConection));
    }
  }

  void _onFilterCatInformationByName(
      FilterCatInformationByName event, Emitter<CatInformationState> emit) {
    if (event.query.isEmpty) {
      emit(CatInformationLoaded(catInformationList));
    } else {
      final filterCatInformation = catInformationList
          .where((catInformation) => catInformation.name
              .toLowerCase()
              .startsWith(event.query.toLowerCase()))
          .toList();
      emit(CatInformationLoaded(filterCatInformation));
    }
  }
}
