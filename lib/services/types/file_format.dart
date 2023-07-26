import 'package:file_selector/file_selector.dart';

const XTypeGroup csvFmt = XTypeGroup(
  label: 'CSV UTF-8 (Comma-delimited) (.csv)',
  extensions: ['csv'],
);

const XTypeGroup dbFmt = XTypeGroup(
  label: 'Database (.sqlite3)',
  extensions: ['sqlite3', 'db'],
);

const XTypeGroup pdfFmt = XTypeGroup(
  label: 'PDF (.pdf)',
  extensions: ['pdf'],
);

const List<XTypeGroup> imageFmt = [
  jpegFmt,
  pngFmt,
  gifFmt,
  heicFmt,
];

const XTypeGroup jpegFmt = XTypeGroup(
  label: 'JPEG (.jpg)',
  extensions: ['jpg', 'jpeg'],
);

const XTypeGroup pngFmt = XTypeGroup(
  label: 'PNG (.png)',
  extensions: ['png'],
);

const XTypeGroup gifFmt = XTypeGroup(
  label: 'GIF (.gif)',
  extensions: ['gif'],
);

const XTypeGroup heicFmt = XTypeGroup(
  label: 'HEIC (.heic)',
  extensions: ['heic'],
);
