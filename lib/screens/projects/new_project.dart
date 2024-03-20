import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/screens/projects/components/project_form.dart';
import 'package:nahpu/services/project_services.dart';

class CreateProjectForm extends ConsumerStatefulWidget {
  const CreateProjectForm({super.key});

  @override
  CreateProjectFormState createState() => CreateProjectFormState();
}

class CreateProjectFormState extends ConsumerState<CreateProjectForm> {
  final _uuidKey = uuid;
  final ProjectFormCtrModel projectCtr = ProjectFormCtrModel.empty();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    projectCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new project'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withAlpha(80),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const QrIcon(),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Scan QR',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const WidgetSpan(
                                child: InfoButton(
                              content: Text(
                                'Scan QR code from other projects to import data. '
                                'This method is useful when multiple devices are '
                                'used to manage the same project. '
                                'To get the QR code, go to the project dashboard '
                                'in the other device. '
                                'Scan the QR code in the project overview. '
                                'You can also tap the QR code to enlarge it.',
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ProjectForm(
              projectCtr: projectCtr,
              projectUuid: _uuidKey,
            )
          ],
        ),
      ),
    );
  }
}

class QrIcon extends StatelessWidget {
  const QrIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/qr-code.svg',
      width: 100,
      height: 100,
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.onSurface,
        BlendMode.srcIn,
      ),
    );
  }
}
