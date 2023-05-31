import 'dart:io';

import 'package:nahpu/services/io_services.dart';
import 'package:archive/archive_io.dart';

class ArchiveServices extends DbAccess {
  const ArchiveServices({
    required super.ref,
    required this.outputFile,
  });

  final File outputFile;

  Future<void> createArchive() async {
    final projectDir = await FileServices(ref: ref).getProjectDir();
    projectDir.createSync(recursive: true);
    // Create the archive
    ZipFileEncoder encoder = ZipFileEncoder();
    encoder.zipDirectory(
      projectDir,
      filename: outputFile.path,
    );
  }
}
