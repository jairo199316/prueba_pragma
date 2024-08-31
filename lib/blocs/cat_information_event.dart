import 'package:equatable/equatable.dart';

abstract class CatInformationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCatInformation extends CatInformationEvent {}

class FilterCatInformationByName extends CatInformationEvent {
  final String query;

  FilterCatInformationByName(this.query);
}
