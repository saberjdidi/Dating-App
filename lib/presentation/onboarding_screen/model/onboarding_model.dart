/// This class defines the variables used in the [onboarding_one_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class OnboardingModel {
  final String? title;
  final String? image;
  final String? body;

  OnboardingModel({this.body, this.title, this.image});
}
