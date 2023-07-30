import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/screens/settings/common.dart';
import 'package:nahpu/screens/settings/db_settings.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/platform_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/utility_services.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/providers/settings.dart';

class AppearanceSetting extends ConsumerWidget {
  const AppearanceSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeSettingProvider);
    return CommonSettingSection(
      title: 'Applications',
      children: [
        theme.when(
          data: (themeValue) => CommonSettingTile(
            isNavigation: true,
            icon: Icons.color_lens_outlined,
            title: 'Theme',
            value: themeValue.name.toSentenceCase(),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ThemeSettings(isSelected: themeValue.name.toSentenceCase()),
              ),
            ),
          ),
          loading: () => const CommonProgressIndicator(),
          error: (error, stackTrace) => const Text('Error'),
        ),
        CommonSettingTile(
          isNavigation: true,
          icon: MdiIcons.databaseOutline,
          title: 'Database',
          label: 'Replace database',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DatabaseSettings(),
            ),
          ),
        ),
      ],
    );
  }
}

class ThemeSettings extends ConsumerStatefulWidget {
  const ThemeSettings({Key? key, required this.isSelected}) : super(key: key);
  final String isSelected;
  @override
  ThemeSettingState createState() => ThemeSettingState();
}

class ThemeSettingState extends ConsumerState<ThemeSettings> {
  final List<String> themes = ['Dark', 'Light', 'System'];
  final List<IconData> icons = [
    Icons.brightness_3_rounded,
    Icons.wb_sunny_rounded,
    systemIcon
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
      ),
      body: CommonSettingList(
        sections: [
          CommonSettingSection(
            title: 'Theme',
            children: themes.map(
              (e) {
                return CommonSettingTile(
                    icon: icons[themes.indexOf(e)],
                    title: e,
                    trailing:
                        widget.isSelected == e ? const Icon(Icons.check) : null,
                    onTap: () {
                      ref.read(themeSettingProvider.notifier).setTheme(e);
                      Navigator.of(context).pop();
                    });
              },
            ).toList(),
          )
        ],
      ),
    );
  }
}
