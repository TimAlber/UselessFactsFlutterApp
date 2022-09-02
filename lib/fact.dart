import 'dart:convert';

UselessFact uselessFactFromJson(String str) =>
    UselessFact.fromJson(json.decode(str));

String uselessFactToJson(UselessFact data) => json.encode(data.toJson());

class UselessFact {
  UselessFact({
    required this.id,
    required this.text,
    required this.source,
    required this.sourceUrl,
    required this.language,
    required this.permalink,
  });

  String id;
  String text;
  String source;
  String sourceUrl;
  String language;
  String permalink;

  factory UselessFact.fromJson(Map<String, dynamic> json) => UselessFact(
        id: json["id"],
        text: json["text"],
        source: json["source"],
        sourceUrl: json["source_url"],
        language: json["language"],
        permalink: json["permalink"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "source": source,
        "source_url": sourceUrl,
        "language": language,
        "permalink": permalink,
      };
}
