import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/collevents.dart';
import 'package:nahpu/screens/settings/common.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:settings_ui/settings_ui.dart';

class CollEventSelection extends StatefulWidget {
  const CollEventSelection({super.key});

  @override
  State<CollEventSelection> createState() => _CollEventSelectionState();
}

class _CollEventSelectionState extends State<CollEventSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SettingTitle(
          title: 'Collection Event Settings',
        ),
      ),
      body: const SafeArea(
        child: SettingsList(
          sections: [
            SettingsSection(
              title: SettingTitle(
                title: 'Collection Methods',
              ),
              tiles: [
                CustomSettingsTile(child: CollMethodSettings()),
              ],
            ),
            SettingsSection(
              title: SettingTitle(
                title: 'Personnel Roles',
              ),
              tiles: [
                CustomSettingsTile(child: PersonnelRoleSetting()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CollMethodSettings extends ConsumerWidget {
  const CollMethodSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController();
    return SettingChip(
      controller: controller,
      chipList: ref.watch(collEventMethodProvider).when(
            data: (data) {
              return data.map((e) {
                return CommonChip(
                  text: e,
                  primaryColor: Theme.of(context).colorScheme.secondary,
                  onDeleted: () {
                    CollMethodServices(ref).removeMethod(e);
                  },
                );
              }).toList();
            },
            loading: () => [const CommonProgressIndicator()],
            error: (e, _) => [Text('Error: $e')],
          ),
      labelText: 'Add method',
      hintText: 'Enter method',
      onPressed: () {
        CollMethodServices(ref).addMethod(
          controller.text.trim(),
        );
        controller.clear();
      },
      resetLabel: 'Reset methods',
      onReset: () {
        CollMethodServices(ref).getAllMethods();
      },
    );
  }
}

class PersonnelRoleSetting extends ConsumerWidget {
  const PersonnelRoleSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController();
    return SettingChip(
      controller: controller,
      chipList: ref.watch(collPersonnelRoleProvider).when(
            data: (data) {
              return data.map((e) {
                return CommonChip(
                  text: e,
                  primaryColor: Theme.of(context).colorScheme.tertiary,
                  onDeleted: () {
                    CollEvenPersonnelServices(ref).removeRole(e);
                  },
                );
              }).toList();
            },
            loading: () => [const CommonProgressIndicator()],
            error: (e, _) => [Text('Error: $e')],
          ),
      labelText: 'Add role',
      hintText: 'Enter role',
      onPressed: () {
        CollEvenPersonnelServices(ref).addRole(controller.text);
        controller.clear();
      },
      resetLabel: 'Reset roles',
      onReset: () {
        CollEvenPersonnelServices(ref).getAllRoles();
      },
    );
  }
}
