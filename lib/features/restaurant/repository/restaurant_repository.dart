import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_url.dart';
import '../model/restaurant_model.dart';

class RestaurantRepository {
  final ApiClient _client = ApiClient.instance;

  Future<Either<String, List<MealCategory>>> getCategories() async {
    try {
      final res = await _client.get(ApiUrl.categoryList);
      if (res != null) {
        dynamic data = res;
        if (data is String) data = jsonDecode(data);
        if (data is Map<String, dynamic>) {
          final parsed = MealCategoryResponse.fromJson(data);
          return Right(parsed.meals);
        }
      }
      return const Left('Failed to fetch categories');
    } on DioException catch (e) {
      return Left('API Error: ${e.message}');
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, List<MealItem>>> getMealsByCategory(String category) async {
    try {
      final res = await _client.get(
        ApiUrl.filterByCategory,
        queryParameters: {'c': category},
      );
      if (res != null) {
        dynamic data = res;
        if (data is String) data = jsonDecode(data);
        if (data is Map<String, dynamic>) {
          final parsed = MealFilterResponse.fromJson(data, category: category);
          return Right(parsed.meals);
        }
      }
      return const Left('Failed to fetch meals');
    } on DioException catch (e) {
      return Left('API Error: ${e.message}');
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
