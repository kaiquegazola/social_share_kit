class WhatsAppModel {
  WhatsAppModel({
    this.text,
  });

  final String? text;

  Map<String, dynamic> toTextMap() {
    return <String, dynamic>{
      'text': text,
    };
  }
}
