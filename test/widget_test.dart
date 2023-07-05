// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cut_link_project/domain/usecases/link_usecases.dart';
import 'package:cut_link_project/view/controllers/main_controller.dart';
import 'package:cut_link_project/view/widgets/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:cut_link_project/main.dart';
import 'package:mockito/mockito.dart';

class MockGets with Mock implements LinkUseCases {}
class MockMainController extends GetxService
    with Mock
    implements MainController {
      final _currentShortLink = ''.obs;
      final _isLoading = false.obs;
      @override
      RxString  get currentShortLink => _currentShortLink;
      @override
      RxBool get isLoading => _isLoading;

      @override
      Future<void> getShortLink(link) async {
        if(link == "https://www.google.com"){
          _currentShortLink.value = "https://cleanuri.com/xo06VK";
        }
      }
}
void main() {
  setUp(() {
    final MockMainController _mockHome = MockMainController();
    Get.put<MainController>(_mockHome);

    final MockGets _mockGets = MockGets();
    Get.put<LinkUseCases>(_mockGets);
  });

  testWidgets('show content form instead loading', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    WidgetsFlutterBinding.ensureInitialized();

    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(),
      ),
    );
    await tester.pump();
    expect(find.byKey(Key('TextFieldLink')), findsOneWidget);
    expect(find.text('Acortar link'), findsOneWidget);
    expect(find.byKey(Key('progressBarIndicator')), findsNothing);

  });

  testWidgets('validate error empty url', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    WidgetsFlutterBinding.ensureInitialized();

    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(),
      ),
    );
    await tester.pump();
    await tester.tap(find.text('Acortar link'));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Debe ingresar una url'), findsOneWidget);

  });

  testWidgets('validate hide loading when empty input', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    WidgetsFlutterBinding.ensureInitialized();

    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Acortar link'));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byKey(Key('TextFieldLink')), findsOneWidget);
    expect(find.text('Acortar link'), findsOneWidget);
    expect(find.byKey(Key('progressBarIndicator')), findsNothing);

  });

  testWidgets('validate error invalid url', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    WidgetsFlutterBinding.ensureInitialized();

    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byKey(Key('TextFieldLink')), '12345');
    await tester.tap(find.text('Acortar link'));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('No es una url válida. Ejemplo: https://www.google.com'), findsOneWidget);

  });

  testWidgets('validate hide loading when incorrect input', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    WidgetsFlutterBinding.ensureInitialized();

    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byKey(Key('TextFieldLink')), '12345');
    await tester.tap(find.text('Acortar link'));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byKey(Key('TextFieldLink')), findsOneWidget);
    expect(find.text('Acortar link'), findsOneWidget);
    expect(find.byKey(Key('progressBarIndicator')), findsNothing);

  });

  testWidgets('validate no error valid url', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    WidgetsFlutterBinding.ensureInitialized();

    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byKey(Key('TextFieldLink')), 'https://www.google.com');
    await tester.tap(find.text('Acortar link'));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('No es una url válida. Ejemplo: https://www.google.com'), findsNothing);
    expect(find.text('Debe ingresar una url'), findsNothing);
  });


}
