import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/specimens.dart';
import 'package:nahpu/screens/shared/media.dart';
import 'package:nahpu/services/import/multimedia.dart';
import 'package:nahpu/services/specimen_services.dart';

class SpecimenMediaForm extends ConsumerStatefulWidget {
  const SpecimenMediaForm({super.key, required this.specimenUuid});

  final String specimenUuid;

  @override
  SpecimenMediaFormState createState() => SpecimenMediaFormState();
}

class SpecimenMediaFormState extends ConsumerState<SpecimenMediaForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(specimenMediaProvider(specimenUuid: widget.specimenUuid))
        .when(
          data: (data) {
            return MediaViewer(
              images: List.from(data),
              onAddImage: () async {
                try {
                  List<String> images = await ImageServices(ref).pickImages();
                  if (images.isNotEmpty) {
                    for (String path in images) {
                      await SpecimenServices(ref).createSpecimenMedia(
                        widget.specimenUuid,
                        path,
                      );
                    }
                    setState(() {});
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        e.toString(),
                      ),
                    ),
                  );
                }
              },
              onAccessingCamera: () async {
                try {
                  String? image = await ImageServices(ref).accessCamera();
                  if (image != null) {
                    await SpecimenServices(ref).createSpecimenMedia(
                      widget.specimenUuid,
                      image,
                    );
                    setState(() {});
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        e.toString(),
                      ),
                    ),
                  );
                }
              },
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stack) => Center(
            child: Text(
              error.toString(),
            ),
          ),
        );
  }
}
