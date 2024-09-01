import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prueba_pragma/blocs/cat_information_bloc.dart';
import 'package:prueba_pragma/blocs/cat_information_event.dart';
import 'package:prueba_pragma/blocs/cat_information_state.dart';
import 'package:prueba_pragma/models/cat_information.dart';
import 'package:prueba_pragma/repositories/cat_information_repository.dart';
import 'package:prueba_pragma/utilities/strings.dart';

class MockCatInformationRepository extends Mock
    implements CatInformationRepository {}

void main() {
  late MockCatInformationRepository mockCatInformationRepository;
  late CatInformationBloc catInformationBloc;

  setUp(() {
    mockCatInformationRepository = MockCatInformationRepository();
    catInformationBloc = CatInformationBloc(mockCatInformationRepository);
  });

  tearDown(() {
    catInformationBloc.close();
  });

  group('catInformationBloc', () {
    final mockCatInformation = [
      CatInformation(
          name: "Abyssinian",
          origin: "Egypt",
          intelligence: "5",
          description:
              "The Abyssinian is easy to care for, and a joy to have in your home. "
              "They’re affectionate cats and love both people and other animals.",
          imageId: "0XYvRd7oD"),
      CatInformation(
          name: "Aegean",
          origin: "Greece",
          intelligence: "3",
          description:
              "Native to the Greek islands known as the Cyclades in the "
              "Aegean Sea, these are natural cats, meaning they developed without "
              "humans getting involved in their breeding. As a breed, Aegean Cats "
              "are rare, although they are numerous on their home islands. They are "
              "generally friendly toward people and can be excellent cats for families "
              "with children.",
          imageId: "ozEvzdVM-")
    ];

    blocTest<CatInformationBloc, CatInformationState>(
        'emits [CatInformationLoading, CatInformationLoaded] when FetchCatInformation '
        'is added and repository returns data',
        build: () {
          when(() => mockCatInformationRepository.getCatsInformation())
              .thenAnswer((_) async => mockCatInformation);
          return catInformationBloc;
        },
        act: (bloc) => bloc.add(FetchCatInformation()),
        expect: () => [
              CatInformationLoading(),
              CatInformationLoaded(mockCatInformation)
            ]);

    blocTest<CatInformationBloc, CatInformationState>(
        'emits [CatInformationLoading, CatInformationError] when FetchCatInformation '
        'is added and repository throws error',
        build: () {
          when(() => mockCatInformationRepository.getCatsInformation())
              .thenThrow(Exception(failConection));
          return catInformationBloc;
        },
        act: (bloc) => bloc.add(FetchCatInformation()),
        expect: () =>
            [CatInformationLoading(), CatInformationError(failConection)]);

    blocTest<CatInformationBloc, CatInformationState>(
        'emits [CatInformationLoaded] when FilterCatInformationByName '
        'is added',
        build: () {
          catInformationBloc.catInformationList = mockCatInformation;
          return catInformationBloc;
        },
        act: (bloc) => bloc.add(FilterCatInformationByName('Abyssinian')),
        expect: () => [
              CatInformationLoaded([mockCatInformation[0]])
            ]);
  });
}
