import 'package:flutter/material.dart';
import 'package:integrador/ApiServices/form_provider.dart';
import 'package:integrador/Providers/plant_provider.dart';
import 'package:integrador/constants.dart';
import 'package:integrador/models/ResultPropierties.dart';
import 'package:integrador/models/form.dart';
import 'package:integrador/ui/pages/detail_page.dart';
import 'package:integrador/ui/pages/widgets/plant_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {

    var plantProvider = Provider.of<PlantProvider>(context);
    var formProvider = Provider.of<FormProvider>(context);

    List<FormModel> sortedList = List.from(formProvider.formList);
    sortedList.sort((a, b) => b.created_at.compareTo(a.created_at)); // Cambiado el orden de comparación
    sortedList = sortedList.take(10).toList();
    sortedList = sortedList.reversed.toList();




    print('ordenados: $sortedList');

    print('Forms fetched on HomePage load: ${formProvider.formList}');


    ResultProperties getResultProperties(int percResult) {
      if (percResult >= 80 && percResult <= 100) {
        return ResultProperties(
          title: 'High Conduct',
          description:
          'Your energy management with all devices, from desktop computers to servers, is just really good.',
          rating: 5.0,
          icon: const Icon(Icons.energy_savings_leaf, color: Colors.white,),
          message: 'Congrats',
          image: 'assets/images/plant-one.png',
        );
      } else if (percResult >= 50 && percResult < 80) {
        return ResultProperties(
          title: 'Moderate Conduct',
          description:
          'The performance was satisfactory; It was not perfect, you have to improve specific things like trying to be in the energy range.',
          rating: 4.0,
          icon: const Icon(Icons.lightbulb, color: Colors.white,),
          message: 'Good',
          image: 'assets/images/plant-two.png',

        );
      } else if (percResult >= 25 && percResult < 50) {
        return ResultProperties(
          title: 'Low Conduct',
          description: 'The performance was not the best, there are some things that were used in the best way but many things need to be improved.',
          rating: 3.5,
          icon: const Icon(Icons.sentiment_satisfied, color: Colors.white,),
          message: 'Raise',
          image: 'assets/images/plant-three.png',

        );
      } else {
        return ResultProperties(
            title: 'Very Low Conduct',
            description: 'Check this things: Servers connected without use, Try to use renewable energy, Use of ENERGY STAR devices, Implement automatic shutdown policies',
            rating: 3.0,
            icon: const Icon(Icons.sentiment_dissatisfied, color: Colors.white,),
            message: 'Improve',
            image: 'assets/images/plant-four.png'

        );
      }
    }







    int selectedIndex = 0;

    Size size = MediaQuery.of(context).size;

    // Plants category
    List<String> _planTypes = [
      'Recommended',
      'Best',
      'Worst',
      'Garden',
      'Supplement'
    ];

    bool toogleIsFavorated(bool isFavorited) {
      return !isFavorited;
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .start, // Dependiendo si es un colum o un row va actuar de una manera un tanto diferente.
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  width: size.width * .9,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black54.withOpacity(.6),
                      ),
                      const Expanded(
                          child: TextField(
                        showCursor: false,
                        decoration: InputDecoration(
                          hintText: 'Search plant',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      )),
                      Icon(
                        Icons.mic,
                        color: Colors.black54.withOpacity(.6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ), // Bucador
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 50.0,
              width: size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _planTypes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Text(
                          _planTypes[index],
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: selectedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.w300,
                              color: selectedIndex == index
                                  ? Constants.primaryColor
                                  : Constants.blackColor),
                        ),
                      ),
                    );
                  })), // Zona de palabras
          SizedBox(
            height: size.height * .3,
            child: ListView.builder(
                itemCount: formProvider.formList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  var form = formProvider.formList[index];
                  ResultProperties resultProperties =
                  getResultProperties(formProvider.formList[index].percResult);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: DetailPage(
                                formId: form.id,
                                updateFavoriteStatus: (isFavorited) {
                                  formProvider.updateFormFavoriteStatus(form.id, isFavorited);
                                },
                              ),
                              type: PageTransitionType.bottomToTop,
                              duration: const Duration(milliseconds: 400)));
                    },
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Constants.primaryColor.withOpacity(.8),
                          borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            right: 20,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    bool isFavorited = toogleIsFavorated(
                                        formProvider.formList[index].isFavorated);
                                    formProvider.formList[index].isFavorated =
                                        isFavorited;
                                  });
                                },
                                icon: Icon(
                                  formProvider.formList[index].isFavorated == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Constants.primaryColor,
                                ),
                                iconSize: 30,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 50,
                            right: 50,
                            top: 50,
                            bottom: 50,
                            child: Image.asset(resultProperties.image),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 20,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    resultProperties.message,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    resultProperties.title,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]),
                          ),
                          Positioned(
                            bottom: 15,
                            right: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                form.percResult.toString(),
                                style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ), // Plantas
          Container(
            padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
            child: const Text('Latest Forms',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                )),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: size.height * .5,
              child: ListView.builder(
                  itemCount: sortedList.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return FormWidget(
                      index: index,
                      formList: sortedList,
                      updateFavoriteStatus: (isFavorited) {
                        formProvider.updateFormFavoriteStatus(sortedList[index].id, isFavorited);
                      },
                    );
                  }))
        ],
      ),
    ));
  }
}


