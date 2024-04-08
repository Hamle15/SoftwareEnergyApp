import 'package:flutter/material.dart';
import 'package:integrador/constants.dart';
import 'package:integrador/models/plants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;

    // Todo: Make the object for the model
    List<Plant> _plantsList = Plant.plantList;

    // Plants category
    List<String> _planTypes = [
      'Recommended',
      'Best',
      'Worst',
      'Garden',
      'Supplement'
    ];

    bool toogleIsFavorated(bool isFavorited){
      return !isFavorited;
    }


    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Dependiendo si es un colum o un row va actuar de una manera un tanto diferente.
          children: [
            Container(
              padding:const EdgeInsets.only(top: 20),
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
                        Icon(Icons.search, color: Colors.black54.withOpacity(.6),),
                        const Expanded(child: TextField(
                          showCursor: false,
                          decoration: InputDecoration(
                            hintText: 'Search plant',

                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        )),
                        Icon(Icons.mic, color: Colors.black54.withOpacity(.6),),
                      ],
                    ),
                  ),
                ],
              ),

            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 50.0,
              width: size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: _planTypes.length,
                  itemBuilder: (BuildContext context, int index){
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Text(
                      _planTypes[index],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.w300,
                        color: selectedIndex == index ? Constants.primaryColor : Constants.blackColor
                      ),
                    ),
                  ),
                );
              })
            ),
            SizedBox(
              height: size.height * .3,
              child: ListView.builder(
                  itemCount: _plantsList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withOpacity(.8),
                      borderRadius: BorderRadius.circular(20)
                    ),
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
                                onPressed: null,
                                icon: Icon(_plantsList[index].isFavorated == true ? Icons.favorite : Icons.favorite_border),
                                color: Constants.primaryColor,
                                iconSize: 30,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 50,
                          right: 50,
                          top: 50,
                          bottom: 50,
                          child: Image.asset(_plantsList[index].imageURL),
                        ),
                        Positioned(
                          bottom: 15,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(_plantsList[index].category,
                              style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              ),),
                            Text(_plantsList[index].plantName, style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),)
                          ]
                        ),),
                        Positioned(
                          bottom: 15,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(r'$' + _plantsList[index].price.toString(), style: TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 16
                            ),),
                          ),)
                      ],
                    ),
                  );
              }),
            ),
          ],
        ),
      )
    );
  }
}
