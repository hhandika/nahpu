import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nahpu/screens/shared/forms/fields.dart';
import 'package:nahpu/styles/design_tokens.dart';
import 'package:nahpu/styles/themes.dart';

void main() {
  group('AutoCompleteField options view', () {
    const localities = <String>[
      'Indonesia, Sulawesi Selatan, Gunung Bawakaraeng, north slope',
      'Indonesia, Sulawesi Selatan, Gunung Bawakaraeng, south ridge',
    ];

    Widget buildField(FocusNode focusNode, TextEditingController controller) {
      return MaterialApp(
        theme: NahpuTheme.lightTheme(),
        home: Scaffold(
          body: SizedBox(
            width: 320,
            child: AutoCompleteField<String>(
              focusNode: focusNode,
              controller: controller,
              options: localities,
              displayStringFor: (value) => value,
              labelText: 'Find existing locality',
              hintText: 'Type to reuse a saved locality',
              onSelected: (_) {},
            ),
          ),
        ),
      );
    }

    testWidgets('keeps square top corners and wraps long options', (
      tester,
    ) async {
      final focusNode = FocusNode();
      final controller = TextEditingController();
      addTearDown(focusNode.dispose);
      addTearDown(controller.dispose);

      await tester.pumpWidget(buildField(focusNode, controller));
      await tester.enterText(find.byType(TextFormField), 'Bawakaraeng');
      await tester.pumpAndSettle();

      final optionsMaterial = tester.widget<Material>(
        find
            .ancestor(
              of: find.text(localities.first),
              matching: find.byType(Material),
            )
            .first,
      );
      final shape = optionsMaterial.shape! as RoundedRectangleBorder;
      final borderRadius = shape.borderRadius.resolve(TextDirection.ltr);
      expect(borderRadius.topLeft, Radius.zero);
      expect(borderRadius.topRight, Radius.zero);
      expect(borderRadius.bottomLeft, const Radius.circular(NahpuRadius.md));

      // A narrow field must show the tail that tells the options apart, so the
      // text wraps instead of clipping both options to the same string.
      final optionText = tester.widget<Text>(find.text(localities.first));
      expect(optionText.maxLines, greaterThan(1));
      expect(
        tester.getSize(find.text(localities.first)).height,
        greaterThan(20),
      );
    });
  });
}
