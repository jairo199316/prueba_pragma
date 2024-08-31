import 'package:equatable/equatable.dart';
import 'package:prueba_pragma/models/cat_information.dart';

abstract class CatInformationState extends Equatable {
  @override
  List<Object> get props => [];
}

class CatInformationInitial extends CatInformationState {}

class CatInformationLoading extends CatInformationState {}

class CatInformationLoaded extends CatInformationState {
  final List<CatInformation> catInformationList;

  CatInformationLoaded(this.catInformationList);

  @override
  List<Object> get props => [catInformationList];
}

class CatInformationError extends CatInformationState {
  final String message;

  CatInformationError(this.message);

  @override
  List<Object> get props => [message];
}
