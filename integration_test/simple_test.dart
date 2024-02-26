import 'package:flutter_test/flutter_test.dart';
import 'package:nahpu/src/rust/api/common.dart';

void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // setUpAll(() async => await RustLib.init());
  // testWidgets('Can call rust function', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MyApp());
  //   expect(find.textContaining('Result: `Hello, Tom!`'), findsOneWidget);
  // });
  test("Test Rust initialization", () {
    expect(testRust(), "Hello from NAHPU-API");
  });
}
