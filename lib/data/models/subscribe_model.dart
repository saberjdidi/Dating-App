class SubscribeModel {
  final String? title;
  final String? description;
  final String? details;

  SubscribeModel({
     this.title,
     this.description,
     this.details,
  });

  Map<String, String?> toMap() {
    return {
      'title': title,
      'description': description,
      'details': details,
    };
  }

  factory SubscribeModel.fromMap(Map<String, dynamic> map) {
    return SubscribeModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      details: map['details'] ?? '',
    );
  }
}
