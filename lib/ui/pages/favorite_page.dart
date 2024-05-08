import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integrador/Providers/plant_provider.dart';
import 'package:integrador/constants.dart';
import 'package:integrador/models/plants.dart';
import 'package:integrador/ui/pages/widgets/plant_widget.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  final List<Plant> favoritedPlants;
  const FavoritePage({super.key, required this.favoritedPlants});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {




  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    final plantProvider = Provider.of<PlantProvider>(context);
    debugPrint('Contenido de la lista de plantas favoritas: ${widget.favoritedPlants}');
    debugPrint('Plantas del provider: ${plantProvider.plantsList}');

    return Scaffold(
      body: widget.favoritedPlants.isEmpty || !widget.favoritedPlants.any((plant) => plant.isFavorated)
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/favorited.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your favorited Plants",
                    style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              height: size.height * .5,
              child: ListView.builder(
                itemCount: widget.favoritedPlants.length,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final plant = widget.favoritedPlants[index];
                  if (!plant.isFavorated) {
                    // Si la planta no está marcada como favorita, no la renderizamos
                    return SizedBox.shrink();
                  }
                  return PlantWidget(
                    plantList: widget.favoritedPlants,
                    index: index,
                    updateFavoriteStatus: (isFavorited) {
                      setState(() {
                        // Actualiza la lista de plantas favoritas
                        plantProvider.updatePlantFavoriteStatus(plant.plantId, isFavorited);
                      });
                    },
                  );
                },
              ),
            ),
    );
  }


}
