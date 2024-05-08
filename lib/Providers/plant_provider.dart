import 'package:flutter/cupertino.dart';
import 'package:integrador/models/plants.dart';


class PlantProvider extends ChangeNotifier {
  List<Plant> _plantsList = Plant.plantList;
  List<Plant> get plantsList => _plantsList;

  // Metodo actulizar estado de la planta
  void updatePlantFavoriteStatus(int index, bool isFavorited) {
    _plantsList[index].isFavorated = isFavorited;
    notifyListeners();
  }
}