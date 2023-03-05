class Question {
  String questionText;
  bool questionAnswer;

  Question(this.questionText, this.questionAnswer);

  //  NULL SAFETY TIP: If you want named parameters
  // https://github.com/DetainedDeveloper/App-Brewery-Flutter-Null-Safety#section-10--quizzler-app-lesson-94
  // Question({required this.questionText, required this.questionAnswer});
}
