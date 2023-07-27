
class LinkData{
  int? id;
  String originalLink;
  String? shortLink;

  LinkData({
    this.id,
    required this.originalLink,
    this.shortLink
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'original_link': originalLink,
      'short_link': shortLink
    };
  }
}