class Meal {
  String? title;
  int? steps;
  CookingTime? cookingTime;
  String? difficulty;
  double? overallRating;
  double? totalCalories;

  Meal(
    {
      this.title,
      this.steps,
      this.cookingTime,
      this.difficulty,
      this.overallRating,
      this.totalCalories
    }
  );
}

class CookingTime {
  int? hours;
  int? minutes;

  CookingTime({
    this.hours,
    this.minutes
  });
}