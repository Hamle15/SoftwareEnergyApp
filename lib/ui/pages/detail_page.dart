import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integrador/ApiServices/form_provider.dart';
import 'package:integrador/constants.dart';
import 'package:integrador/models/ResultPropierties.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String formId;
  final Function(bool) updateFavoriteStatus;
  const DetailPage(
      {Key? key, required this.formId, required this.updateFavoriteStatus})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;
  bool isFavoriteChanged =
      false;

  @override
  void initState() {
    super.initState();
    final formProvider = Provider.of<FormProvider>(context, listen: false);
    var form =
        formProvider.formList.firstWhere((form) => form.id == widget.formId);
    isFavorite = form.isFavorated;
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    var formSelected =
        formProvider.formList.firstWhere((form) => form.id == widget.formId);
    Size size = MediaQuery.of(context).size;

    ResultProperties getResultProperties(int percResult) {
      if (percResult >= 80 && percResult <= 100) {
        return ResultProperties(
            title: 'High Conduct',
            description:
                'Your energy management with all devices, from desktop computers to servers, is just really good.',
            rating: 5.0,
            icon: const Icon(Icons.energy_savings_leaf, color: Colors.white,),
            message: 'CONGRATULATION',
            image: 'assets/images/plant-one.png',
        );
      } else if (percResult >= 50 && percResult < 80) {
        return ResultProperties(
            title: 'Moderate Conduct',
            description:
                'The performance was satisfactory; It was not perfect, you have to improve specific things like trying to be in the energy range.',
            rating: 4.0,
            icon: const Icon(Icons.lightbulb, color: Colors.white,),
            message: 'CONTINUE LIKE THAT',
            image: 'assets/images/plant-two.png',

        );
      } else if (percResult >= 25 && percResult < 50) {
        return ResultProperties(
            title: 'Low Conduct',
            description: 'The performance was not the best, there are some things that were used in the best way but many things need to be improved.',
            rating: 3.5,
            icon: const Icon(Icons.sentiment_satisfied, color: Colors.white,),
            message: 'YOU CAN DO IT',
            image: 'assets/images/plant-three.png',

        );
      } else {
        return ResultProperties(
            title: 'Poor',
            description: 'Check this things: Servers connected without use, Try to use renewable energy, Use of ENERGY STAR devices, Implement automatic shutdown policies',
            rating: 3.0,
            icon: const Icon(Icons.sentiment_dissatisfied, color: Colors.white,),
            message: 'IMPROVE',
            image: 'assets/images/plant-four.png'

        );
      }
    }

    ResultProperties resultProperties =
        getResultProperties(formSelected.percResult);
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
                      Navigator.pop(context,
                          isFavorite); // Pasa el estado de favoritos actualizado a FavoritePage
                    } else {
                      Navigator.pop(
                          context); // Si no ha cambiado, simplemente cierra DetailPage
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
                      isFavoriteChanged =
                          true; // Marca que el estado de favoritos ha cambiado
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
                        child: Image.asset(resultProperties.image),
                      ),
                    ),
                    Positioned(
                        top: 10,
                        right: 0,
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PlantFeatures(
                                title: "All devices",
                                plantFatures:
                                    formSelected.allDevicesNum1.toString(),
                              ),
                              PlantFeatures(
                                title: "Desktop",
                                plantFatures:
                                    formSelected.deskCompNum2.toString(),
                              ),
                              PlantFeatures(
                                title: "Servers",
                                plantFatures:
                                    formSelected.numberServers5.toString(),
                              ),
                              PlantFeatures(
                                title: "Laptops",
                                plantFatures:
                                    formSelected.numberLaptops8.toString(),
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
                              resultProperties.title,
                              style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              r"Result: " +
                                  formSelected.percResult.toString() +
                                  r"%",
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
                              resultProperties.rating.toString(),
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
                      resultProperties.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 18,
                          color: Constants.blackColor.withOpacity(.7)),
                    ))
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
              decoration: BoxDecoration(
                  color: Constants.primaryColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 5,
                        color: Constants.primaryColor.withOpacity(.3))
                  ]),
              child: resultProperties.icon,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Constants.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 5,
                        color: Constants.primaryColor.withOpacity(.3))
                  ]),
              child: Center(
                child: Text(
                  resultProperties.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
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
