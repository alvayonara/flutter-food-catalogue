class MealModel {
  final String strMeal;
  final String strMealThumb;
  final String idMeal;
  final String strIngredient1;
  final String strIngredient2;
  final String strIngredient3;
  final String strIngredient4;
  final String strIngredient5;

  MealModel(
      this.strMeal,
      this.strMealThumb,
      this.idMeal,
      this.strIngredient1,
      this.strIngredient2,
      this.strIngredient3,
      this.strIngredient4,
      this.strIngredient5);

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
        json['strMeal'],
        json['strMealThumb'],
        json['idMeal'],
        json['strIngredient1'],
        json['strIngredient2'],
        json['strIngredient3'],
        json['strIngredient4'],
        json['strIngredient5']);
  }
}
