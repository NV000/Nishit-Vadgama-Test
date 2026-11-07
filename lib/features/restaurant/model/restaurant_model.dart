class MealCategoryResponse {
  final List<MealCategory> meals;

  MealCategoryResponse({this.meals = const []});

  factory MealCategoryResponse.fromJson(Map<String, dynamic> json) {
    return MealCategoryResponse(
      meals: (json['meals'] as List<dynamic>?)
              ?.map((e) => MealCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'meals': meals.map((e) => e.toJson()).toList(),
      };
}

class MealCategory {
  final String strCategory;

  MealCategory({required this.strCategory});

  factory MealCategory.fromJson(Map<String, dynamic> json) {
    return MealCategory(
      strCategory: json['strCategory']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'strCategory': strCategory,
      };
}

class MealFilterResponse {
  final List<MealItem> meals;

  MealFilterResponse({this.meals = const []});

  factory MealFilterResponse.fromJson(Map<String, dynamic> json, {String? category}) {
    return MealFilterResponse(
      meals: (json['meals'] as List<dynamic>?)
              ?.map((e) => MealItem.fromJson(
                    e as Map<String, dynamic>,
                    category: category,
                  ))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'meals': meals.map((e) => e.toJson()).toList(),
      };
}

class MealItem {
  final String strMeal;
  final String strMealThumb;
  final String idMeal;
  final String? strArea;
  final String? strCountry;
  final String? category;

  MealItem({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
    this.strArea,
    this.strCountry,
    this.category,
  });

  double get price => 50.0;
  int get calories => 10;

  bool get isVeg {
    final cat = (category ?? '').toLowerCase();
    if (cat == 'vegetarian' || cat == 'vegan' || cat == 'dessert') {
      return true;
    }
    final name = strMeal.toLowerCase();
    return name.contains('veg') || name.contains('paneer') || name.contains('salad');
  }

  String get location {
    final area = strArea?.trim();
    final country = strCountry?.trim();
    if (area != null && area.isNotEmpty && country != null && country.isNotEmpty) {
      if (area.toLowerCase() == country.toLowerCase()) return country;
      return '$area, $country';
    }
    if (country != null && country.isNotEmpty) return country;
    if (area != null && area.isNotEmpty) return area;
    return category ?? '';
  }

  factory MealItem.fromJson(Map<String, dynamic> json, {String? category}) {
    return MealItem(
      strMeal: json['strMeal']?.toString() ?? '',
      strMealThumb: json['strMealThumb']?.toString() ?? '',
      idMeal: json['idMeal']?.toString() ?? '',
      strArea: json['strArea']?.toString(),
      strCountry: json['strCountry']?.toString(),
      category: category,
    );
  }

  Map<String, dynamic> toJson() => {
        'strMeal': strMeal,
        'strMealThumb': strMealThumb,
        'idMeal': idMeal,
        'strArea': strArea,
        'strCountry': strCountry,
        'category': category,
      };
}
