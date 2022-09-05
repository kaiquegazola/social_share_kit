class TwitterModel {
  TwitterModel({
    this.text,
  });

  final String? text;

  Map<String, dynamic> toTextMap() {
    return <String, dynamic>{
      'tweetText': text,
    };
  }
}
