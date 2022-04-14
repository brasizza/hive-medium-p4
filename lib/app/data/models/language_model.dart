import 'dart:convert';

class Language {
  final String lang;
  final String contryCode;
  final String flag;
  Language({
    required this.lang,
    required this.contryCode,
    required this.flag,
  });
  Map<String, dynamic> toMap() {
    return {
      'lang': lang,
      'country_code': contryCode,
      'flag': flag,
    };
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      lang: map['lang'] ?? '',
      contryCode: map['country_code'] ?? '',
      flag: map['flag'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());
  factory Language.fromJson(String source) => Language.fromMap(json.decode(source));
}
