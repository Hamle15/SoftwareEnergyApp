import 'package:flutter/material.dart';
import 'package:integrador/ApiServices/form_provider.dart';
import 'package:integrador/Providers/plant_provider.dart';
import 'package:integrador/constants.dart';
import 'package:integrador/models/ResultPropierties.dart';
import 'package:integrador/models/form.dart';
import 'package:integrador/models/plants.dart';
import 'package:integrador/ui/pages/detail_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class FormWidgetFavorite extends StatelessWidget {

  final int index;
  final Function(bool) updateFavoriteStatus;

  const FormWidgetFavorite({
    Key? key,
    required this.index,
    required this.updateFavoriteStatus,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final formProvider = Provider.of<FormProvider>(context);


    List<FormModel> form = List.from(formProvider.formList);
    form = formProvider.formList.where((form) => form.isFavorated).toList();




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

    ResultProperties resultProperties =
    getResultProperties(form[index].percResult);


    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: DetailPage(
                  formId: form[index].id,
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
                    child: Image.asset(getImageForPercResult(form[index].percResult)),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(resultProperties.message),
                      Text(resultProperties.title,
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
                form[index].percResult.toString() + r"%",
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

  String getImageForPercResult(int percResult) {
    if (percResult >= 80 && percResult <= 100) {
      return 'assets/images/plant-one.png';
    } else if (percResult >= 50 && percResult < 80) {
      return 'assets/images/plant-two.png';
    } else if (percResult >= 25 && percResult < 50) {
      return 'assets/images/plant-three.png';
    } else {
      return 'assets/images/plant-four.png';
    }
  }

}