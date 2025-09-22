class UserModel {
  int? id;
  final String imageProfile;
  final String fullName;
  final String bio;
  final int age;
  List<String>? interests;
  List<String>? images;
  bool? isFavoris;

  UserModel({
    this.id,
    required this.imageProfile,
    required this.fullName,
    required this.bio,
    required this.age,
    this.interests,
    this.images,
    this.isFavoris,
  });

  static UserModel empty() => UserModel(imageProfile: '', fullName: '', bio: '', age: 10, isFavoris: false, interests: [], images: []);
}