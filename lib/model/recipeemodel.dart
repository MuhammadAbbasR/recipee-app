class RecipeeModel {
  int id;
  String name;
  List<String> ingredients;
  // List<String> instructions;
  int prepTimeMinutes;
  int cookTimeMinutes;
  int servings;
  String difficulty;
  String cuisine;
  int caloriesPerServing;
  List<String> instruction;
  String image;
  double rating;
  int reviewCount;
  List<String> mealType;

  RecipeeModel({
    required this.id,
    required this.name,
    required this.ingredients,
      required this.instruction,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.mealType,
  });

  factory RecipeeModel.fromJson(Map<String, dynamic> json) {
    return RecipeeModel(
        id: json["id"],
        name: json["name"],
        ingredients: List<String>.from(json["ingredients"]),
        instruction: List<String>.from(json["instructions"]),
        prepTimeMinutes: json["prepTimeMinutes"],
        cookTimeMinutes: json["cookTimeMinutes"],
        servings: json["servings"],
        difficulty: json["difficulty"],
        cuisine: json["cuisine"],
        caloriesPerServing: json["caloriesPerServing"],
        image: json["image"],
        rating: json["rating"],
        reviewCount: json["reviewCount"],
        mealType:  List<String>.from(json['mealType'] ?? []),

        );
  }
}
