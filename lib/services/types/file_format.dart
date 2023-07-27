import 'package:file_selector/file_selector.dart';

const XTypeGroup csvFmt = XTypeGroup(
  label: 'CSV UTF-8 (Comma-delimited) (.csv)',
  extensions: ['csv'],
  uniformTypeIdentifiers: ['public.comma-separated-values-text'],
);

const XTypeGroup dbFmt = XTypeGroup(
  label: 'Database (.sqlite3)',
  extensions: ['sqlite3', 'db'],
  uniformTypeIdentifiers: ['public.database'],
  mimeTypes: ['application/vnd.sqlite3'],
);

const XTypeGroup pdfFmt = XTypeGroup(
  label: 'PDF (.pdf)',
  extensions: ['pdf'],
  uniformTypeIdentifiers: ['com.adobe.pdf'],
  mimeTypes: ['application/pdf'],
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
  uniformTypeIdentifiers: ['public.jpeg'],
  mimeTypes: ['image/jpeg'],
);

const XTypeGroup pngFmt = XTypeGroup(
  label: 'PNG (.png)',
  extensions: ['png'],
  uniformTypeIdentifiers: ['public.png'],
  mimeTypes: ['image/png'],
);

const XTypeGroup gifFmt = XTypeGroup(
  label: 'GIF (.gif)',
  extensions: ['gif'],
  uniformTypeIdentifiers: ['com.compuserve.gif'],
  mimeTypes: ['image/gif'],
);

const XTypeGroup heicFmt = XTypeGroup(
  label: 'HEIC (.heic)',
  extensions: ['heic'],
  uniformTypeIdentifiers: ['public.heic'],
  mimeTypes: ['image/heic'],
);
