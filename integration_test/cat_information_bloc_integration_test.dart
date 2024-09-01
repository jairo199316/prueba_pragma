import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prueba_pragma/blocs/cat_information_bloc.dart';
import 'package:prueba_pragma/blocs/cat_information_event.dart';
import 'package:prueba_pragma/models/cat_information.dart';
import 'package:prueba_pragma/repositories/cat_information_repository.dart';
import 'package:prueba_pragma/screens/home_screen.dart';
import 'package:prueba_pragma/utilities/strings.dart';

class MockCatInformationRepository extends Mock
    implements CatInformationRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('CatInformationBloc integration test', () {
    late MockCatInformationRepository mockCatInformationRepository;

    setUp(() {
      mockCatInformationRepository = MockCatInformationRepository();
    });

    testWidgets('Load CatInformationList ', (WidgetTester tester) async {
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

      when(() => mockCatInformationRepository.getCatsInformation())
          .thenAnswer((_) async => mockCatInformation);

      await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
          create: (context) => CatInformationBloc(mockCatInformationRepository)
            ..add(FetchCatInformation()),
          child: const HomeScreen(),
        ),
      ));

      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 8));

      expect(find.text('Abyssinian'), findsOneWidget);
      expect(find.text('Aegean'), findsOneWidget);
    });

    testWidgets('Filter CatInformation by name ', (WidgetTester tester) async {
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

      when(() => mockCatInformationRepository.getCatsInformation())
          .thenAnswer((_) async => mockCatInformation);

      await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
          create: (context) => CatInformationBloc(mockCatInformationRepository)
            ..add(FetchCatInformation()),
          child: const HomeScreen(),
        ),
      ));
      await Future.delayed(const Duration(seconds: 3));

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Abyssi');
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 8));

      expect(find.text('Abyssinian'), findsOneWidget);
      expect(find.text('Aegean'), findsNothing);
    });

    testWidgets('Navigate to detail screen', (WidgetTester tester) async {
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

      when(() => mockCatInformationRepository.getCatsInformation())
          .thenAnswer((_) async => mockCatInformation);

      await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
          create: (context) => CatInformationBloc(mockCatInformationRepository)
            ..add(FetchCatInformation()),
          child: const HomeScreen(),
        ),
      ));

      await Future.delayed(const Duration(seconds: 5));

      await tester.pumpAndSettle();

      final finder = find.text(seeMoreLabelHomeScreen);
      await tester.tap(finder.at(1));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 8));

      expect(find.text(desciptionTittleDetailScreen), findsOneWidget);
    });
  });
}
