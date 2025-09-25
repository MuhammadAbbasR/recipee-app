import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipeapp/service/app_exception.dart';
import '../../model/recipeemodel.dart';


class NetworkApiService {
  static String api_url = "https://dummyjson.com/recipes";

  static Future<List<RecipeeModel>> getApiResponse() async {
    final url = Uri.parse(api_url);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final value = jsonDecode(response.body);
      print(value);
    }

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final value = jsonDecode(response.body);
        final List<dynamic> reply = value["recipes"];

        return reply.map((e) => RecipeeModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load recipes");
      }
    } on TimeoutException {
      throw Exception("Request timed out. Please try again.");
    } on UnauthorisedException {
      throw Exception("UnAuthorized Exception. Please try again.");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
