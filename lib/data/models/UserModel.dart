class UserModel {
  int? id;
  final String imageProfile;
  final String fullName;
  final String bio;
  final int age;

  UserModel({
    this.id,
    required this.imageProfile,
    required this.fullName,
    required this.bio,
    required this.age,
  });

  static UserModel empty() => UserModel(imageProfile: '', fullName: '', bio: '', age: 10);
}