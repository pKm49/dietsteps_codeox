
class AllergyDislikes {

  final List<int> allergies;
  final List<int> allergyCategories;
  final List<int> dislikes;
  final List<int> dislikeCategories;


  AllergyDislikes({
    required this.allergies,
    required this.allergyCategories,
    required this.dislikes,
    required this.dislikeCategories
  });

  Map toJson() => {
    "allergies":allergies,
    "allergy_categories":allergyCategories,
    "dislikes":dislikes,
    "dislike_categories":dislikeCategories
      };
}

AllergyDislikes mapAllergyDislikes(dynamic payload) {
  return AllergyDislikes(
    allergyCategories: payload["allergy_categories"] ?? "",
    allergies: payload["allergies"] ?? "",
    dislikeCategories: payload["dislike_categories"] ?? "",
    dislikes: payload["dislikes"] ?? "",
  );
}
