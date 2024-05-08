import 'package:flutter/material.dart';
import 'package:integrador/Providers/plant_provider.dart';
import 'package:integrador/constants.dart';
import 'package:integrador/models/plants.dart';
import 'package:integrador/ui/pages/detail_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PlantWidget extends StatelessWidget {

  final int index;
  final Function(bool) updateFavoriteStatus;
  final List<Plant> plantList;

  const PlantWidget({
    Key? key,
    required this.plantList,
    required this.index,
    required this.updateFavoriteStatus,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final plantProvider = Provider.of<PlantProvider>(context);


    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: DetailPage(
                  plantId: plantList[index].plantId,
                  updateFavoriteStatus: updateFavoriteStatus,
                ),
                type: PageTransitionType.bottomToTop,
                duration: const Duration(milliseconds: 400)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80.0,
        padding: const EdgeInsets.only(left: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(.8),
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 80.0,
                    child: Image.asset(plantList[index].imageURL),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(plantList[index].category),
                      Text(plantList[index].plantName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Constants.blackColor,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                r'$' + plantList[index].price.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Constants.primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}