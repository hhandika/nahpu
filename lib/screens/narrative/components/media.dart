import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/narrative.dart';
import 'package:nahpu/screens/shared/media.dart';
import 'package:nahpu/services/import/multimedia.dart';
import 'package:nahpu/services/narrative_services.dart';

class MediaForm extends ConsumerStatefulWidget {
  const MediaForm({
    super.key,
    required this.narrativeId,
  });

  final int narrativeId;

  @override
  MediaFormState createState() => MediaFormState();
}

class MediaFormState extends ConsumerState<MediaForm> {
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
        .watch(narrativeMediaProvider(narrativeId: widget.narrativeId))
        .when(
          data: (data) {
            return MediaViewer(
              images: List.from(data),
              onAddImage: () async {
                try {
                  List<String> images = await ImageServices().pickImages();
                  if (images.isNotEmpty) {
                    for (String path in images) {
                      await NarrativeServices(ref).createNarrativeMedia(
                        widget.narrativeId,
                        path,
                      );
                    }
                    setState(() {});
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
              },
              onAccessingCamera: () async {
                try {
                  String? image = await ImageServices().accessCamera();
                  if (image != null) {
                    await NarrativeServices(ref).createNarrativeMedia(
                      widget.narrativeId,
                      image,
                    );
                    setState(() {});
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        );
  }
}
