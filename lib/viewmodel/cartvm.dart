import 'package:flutter/material.dart';
import 'package:recipeapp/model/recipeemodel.dart';

class CartVm extends ChangeNotifier {
  List<RecipeeModel> recipeeList = [];
  List<RecipeeModel> get getRecipeeList => recipeeList;

  void addToCart(RecipeeModel recipeeModel) {
    recipeeList.add(recipeeModel);
    notifyListeners();
  }

  void removeFromCart(RecipeeModel recipeeModel) {
    recipeeList.remove(recipeeModel);
    notifyListeners();
  }

  void increaseServings(RecipeeModel recipeeModel) {
    recipeeModel.servings++;
    notifyListeners();
  }

  void decreaseServings(RecipeeModel recipeeModel) {
    if (recipeeModel.servings > 1) {
      recipeeModel.servings--;
      notifyListeners();
    }
  }
}
