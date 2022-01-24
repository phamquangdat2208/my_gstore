import 'package:html/parser.dart';

extension StringExtension on String? {
  String get toFirstUpperCase {
    return '${this![0].toUpperCase()}${this?.substring(1)}';
  }

  String get toUpperCaseFirstChar {
    if (this == null || (this?.isEmpty ?? true)) {
      return '';
    }
    final listWord = this?.trim().split(' ');
    final resultWord = [];
    for (final obj in listWord ?? []) {
      resultWord.add('${obj[0].toUpperCase()}${obj.substring(1)}');
    }
    return resultWord.join(' ');
  }

  String get removeTagHtml {
    if (this?.isEmpty ?? true) {
      return '';
    }
    final document = parse(this);
    return parse(document.body?.text ?? '').documentElement?.text ?? '';
  }
}
