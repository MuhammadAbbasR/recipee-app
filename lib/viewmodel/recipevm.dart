import 'package:flutter/cupertino.dart';
import 'package:recipeapp/model/recipeemodel.dart';
import 'package:recipeapp/service/network/networkapi.dart';
import 'package:recipeapp/service/response/api_response.dart';

class RecipeVm extends ChangeNotifier {

  ApiResponse<List<RecipeeModel>> response=ApiResponse.notStarted();

  String recipeeList="All";
  String get getRecipeeList => recipeeList;

  Future<void> loadFoodList() async {
    response=ApiResponse.loading();
    notifyListeners();
    try{
      final value=await NetworkApiService.getApiResponse();
      response=ApiResponse.completed(value);
    }
    catch(e){
      response=ApiResponse.error(e.toString());
    }

    notifyListeners();

  }

  void setRecipeeList(String recippe){
    recipeeList=recippe;
    notifyListeners();

  }

}
