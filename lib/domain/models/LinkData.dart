
class LinkData{
  int? id;
  String link;

  LinkData({
    this.id,
    required this.link
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'link': link
    };
  }
}