import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integrador/Providers/plant_provider.dart';
import 'package:integrador/constants.dart';
import 'package:integrador/models/plants.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final int plantId;
  final Function(bool) updateFavoriteStatus;
  const DetailPage(
      {Key? key, required this.plantId, required this.updateFavoriteStatus})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;
  bool isFavoriteChanged = false; // Variable para verificar si el estado de favoritos ha cambiado

  @override
  void initState() {
    super.initState();
    final plantProvider = Provider.of<PlantProvider>(context, listen: false);
    isFavorite = plantProvider.plantsList[widget.plantId].isFavorated;
  }

  @override
  Widget build(BuildContext context) {
    final plantProvider = Provider.of<PlantProvider>(context); // Obtén el Provider
    Plant plant = plantProvider.plantsList[widget.plantId];
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (isFavoriteChanged) {
                      Navigator.pop(context, isFavorite); // Pasa el estado de favoritos actualizado a FavoritePage
                    } else {
                      Navigator.pop(context); // Si no ha cambiado, simplemente cierra DetailPage
                    }

                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Constants.primaryColor.withOpacity(.15)),
                    child: Icon(Icons.close, color: Constants.primaryColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                      isFavoriteChanged = true; // Marca que el estado de favoritos ha cambiado
                    });
                    widget.updateFavoriteStatus(isFavorite);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Constants.primaryColor.withOpacity(.15),
                    ),
                    child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Constants.primaryColor),
                  ),
                )
              ],
            ),
          ), // AppBar
          Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Container(
                width: size.width * .8,
                height: size.height * .8,
                padding: const EdgeInsets.all(20),

                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 0,
                      child: SizedBox(
                        height: 300,
                        child:
                            Image.asset(plant.imageURL),
                      ),
                    ),
                    Positioned(
                        top: 10,
                        right: 0,
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PlantFeatures(
                                title: "Size",
                                plantFatures: plant.size,
                              ),
                              PlantFeatures(
                                title: "Humidity",
                                plantFatures: plant
                                    .humidity
                                    .toString(),
                              ),
                              PlantFeatures(
                                title: "Temperature",
                                plantFatures:
                                plant.temperature,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              )), // Detalles y imagen
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
                height: size.height * .5,
                width: size.width,
                decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(.4),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plant.plantName,
                              style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              r"$" +
                                  plant.price.toString(),
                              style: TextStyle(
                                color: Constants.blackColor,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              plant.rating.toString(),
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Constants.primaryColor,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              size: 30.0,
                              color: Constants.primaryColor,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Expanded(
                        child: Text(
                          plant.decription,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              height: 1.5,
                              fontSize: 18,
                              color: Constants.blackColor.withOpacity(.7)),
                        )
                    )
                  ],
                ),
              )) // Parte Verder
        ],
      ),
      floatingActionButton: SizedBox(
        width: size.width * .9,
        height: 50,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              child: const Icon(Icons.shopping_cart, color: Colors.white),
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(.5),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                    color: Constants.primaryColor.withOpacity(.3)
                  )
                ]
              ),
            ),
            const SizedBox(width: 20,),
            Expanded(child: Container(
              decoration: BoxDecoration(
                color: Constants.primaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                    color: Constants.primaryColor.withOpacity(.3)
                  )
                ]
              ),
              child: const Center(
                child: Text("BUY NOW", style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ) ,),
              ),
            ))
          ],
        ),

      ),
    );
  }
}

class PlantFeatures extends StatelessWidget {
  final String plantFatures;
  final String title;
  const PlantFeatures({
    Key? key,
    required this.plantFatures,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Constants.blackColor),
        ),
        Text(
          plantFatures,
          style: TextStyle(
            color: Constants.primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
