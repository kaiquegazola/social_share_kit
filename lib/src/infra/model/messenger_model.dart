class MessengerModel {
  MessengerModel({
    this.link,
  });

  final String? link;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'link': link,
    };
  }
}
