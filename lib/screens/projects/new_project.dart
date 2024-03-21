import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/platform_services.dart';
import 'package:nahpu/services/providers/validation.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/screens/projects/components/project_form.dart' as project;
import 'package:nahpu/services/project_services.dart';

class CreateProjectForm extends ConsumerStatefulWidget {
  const CreateProjectForm({super.key});

  @override
  CreateProjectFormState createState() => CreateProjectFormState();
}

class CreateProjectFormState extends ConsumerState<CreateProjectForm> {
  String _uuidKey = uuid;
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (systemPlatform == PlatformType.mobile)
              GestureDetector(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScannerScreen(
                        onDetect: (BarcodeCapture barcode) {
                          onDetect(barcode);
                        },
                      ),
                    ),
                  );
                },
              ),
            project.ProjectForm(
              projectCtr: projectCtr,
              projectUuid: _uuidKey,
            )
          ],
        ),
      ),
    );
  }

  void onDetect(BarcodeCapture capture) {
    final Barcode barcode = capture.barcodes.first;

    if (barcode.format != BarcodeFormat.qrCode) {
      _showError('Invalid QR code');
      return;
    }
    final String? qrData = barcode.rawValue;
    if (qrData == null) {
      _showError('Invalid QR code');
      return;
    }
    final Map<String, dynamic> data = jsonDecode(qrData);
    ProjectData projectData = ProjectData.fromJson(data);
    debugPrint('QR data: ${projectData.uuid}');

    _showSuccess(
      projectData.name,
    );
    Navigator.pop(context);
    setState(() {
      projectCtr.updateData(projectData);
      _uuidKey = projectData.uuid;
    });
    ref
        .read(projectFormValidatorProvider.notifier)
        .validateProjectName(projectData.name);
  }

  void _showSuccess(String projectName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          content: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Found ',
                ),
                TextSpan(
                  text: '$projectName! ',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const TextSpan(
                  text: '🎉🎉🎉',
                ),
              ],
            ),
          )),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key, required this.onDetect});

  final void Function(BarcodeCapture) onDetect;

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );

  @override
  void initState() {
    super.initState();
    _controller.start();
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Scan QR code'),
        ),
        body: MobileScanner(
          controller: _controller,
          onDetect: (barcode) {
            widget.onDetect(barcode);
            _controller.stop();
          },
        ));
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
