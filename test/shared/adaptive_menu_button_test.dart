import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nahpu/screens/shared/actions/adaptive_menu.dart';

enum _Action { edit, share, delete }

const _items = [
  AdaptiveMenuItem(
    value: _Action.edit,
    icon: Icons.edit_outlined,
    label: 'Edit',
    hasDividerBefore: true,
  ),
  AdaptiveMenuItem(
    value: _Action.share,
    icon: Icons.share_outlined,
    label: 'Share',
    enabled: false,
  ),
  AdaptiveMenuItem(
    value: _Action.delete,
    icon: Icons.delete_outline,
    label: 'Delete',
    isDestructive: true,
    hasDividerBefore: true,
  ),
];

void main() {
  testWidgets('wide screens show a popup menu', (tester) async {
    final selected = <_Action>[];
    await _pumpMenu(
      tester,
      const Size(600, 900),
      AdaptiveMenuButton<_Action>(
        tooltip: 'Actions',
        itemBuilder: () => _items,
        onSelected: selected.add,
      ),
    );

    expect(find.byType(PopupMenuButton<_Action>), findsOneWidget);
    await tester.tap(find.byTooltip('Actions'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsNothing);
    // The divider before the first item is dropped.
    expect(find.byType(PopupMenuDivider), findsOneWidget);
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(selected, [_Action.delete]);
  });

  testWidgets('compact screens show a bottom sheet', (tester) async {
    final selected = <_Action>[];
    await _pumpMenu(
      tester,
      const Size(599, 900),
      AdaptiveMenuButton<_Action>(
        tooltip: 'Actions',
        itemBuilder: () => _items,
        onSelected: selected.add,
      ),
    );

    expect(find.byType(PopupMenuButton<_Action>), findsNothing);
    await tester.tap(find.byTooltip('Actions'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(
      tester.widget<BottomSheet>(find.byType(BottomSheet)).showDragHandle,
      isTrue,
    );
    expect(find.byType(Divider), findsOneWidget);
    final deleteText = tester.widget<Text>(find.text('Delete'));
    final errorColor = Theme.of(
      tester.element(find.text('Delete')),
    ).colorScheme.error;
    expect(deleteText.style?.color, errorColor);

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsNothing);
    expect(selected, [_Action.edit]);
  });

  for (final width in [599.0, 600.0]) {
    testWidgets('disabled items cannot be chosen at width $width', (
      tester,
    ) async {
      final selected = <_Action>[];
      await _pumpMenu(
        tester,
        Size(width, 900),
        AdaptiveMenuButton<_Action>(
          tooltip: 'Actions',
          itemBuilder: () => _items,
          onSelected: selected.add,
        ),
      );

      await tester.tap(find.byTooltip('Actions'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Share'));
      await tester.pumpAndSettle();

      expect(selected, isEmpty);
      expect(find.text('Share'), findsOneWidget);
    });

    testWidgets('checked items mark the current choice at width $width', (
      tester,
    ) async {
      final selected = <_Action>[];
      await _pumpMenu(
        tester,
        Size(width, 900),
        AdaptiveMenuButton<_Action>(
          tooltip: 'Sort',
          initialValue: _Action.share,
          itemBuilder: () => [
            for (final action in _Action.values)
              AdaptiveMenuItem(
                value: action,
                label: action.name,
                checked: action == _Action.share,
              ),
          ],
          onSelected: selected.add,
        ),
      );

      await tester.tap(find.byTooltip('Sort'));
      await tester.pumpAndSettle();

      if (width < 600) {
        expect(find.byIcon(Icons.check), findsOneWidget);
      } else {
        expect(
          find.byType(CheckedPopupMenuItem<_Action>),
          findsNWidgets(_Action.values.length),
        );
      }
      // CheckedPopupMenuItem keeps pointer events away from its label.
      await tester.tap(
        width < 600
            ? find.text('delete')
            : find.byWidgetPredicate(
                (widget) =>
                    widget is CheckedPopupMenuItem<_Action> &&
                    widget.value == _Action.delete,
              ),
      );
      await tester.pumpAndSettle();

      expect(selected, [_Action.delete]);
    });
  }

  testWidgets('bottom sheet scrolls on short displays', (tester) async {
    final selected = <int>[];
    await _pumpMenu(
      tester,
      const Size(390, 240),
      AdaptiveMenuButton<int>(
        tooltip: 'Actions',
        itemBuilder: () => [
          for (var i = 0; i < 10; i++)
            AdaptiveMenuItem(value: i, label: 'Item $i'),
        ],
        onSelected: selected.add,
      ),
    );

    await tester.tap(find.byTooltip('Actions'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Item 9'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Item 9'));
    await tester.pumpAndSettle();

    expect(selected, [9]);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pumpMenu(WidgetTester tester, Size size, Widget menu) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(appBar: AppBar(actions: [menu])),
    ),
  );
}
