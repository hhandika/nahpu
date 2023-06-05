const String csvDelimiter = ',';
const String tsvDelimiter = '\t';

const String writerSeparator = '|';

extension DelimitedText on List<String> {
  String toDelimitedText(String delimiter) {
    return map((e) => e.contains(delimiter) ? '"$e"' : e).join(delimiter);
  }
}
