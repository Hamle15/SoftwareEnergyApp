import 'package:flutter/material.dart';
import 'package:integrador/ApiServices/form_provider.dart';
import 'package:integrador/constants.dart';
import 'package:integrador/models/form.dart';
import 'package:integrador/ui/pages/widgets/plantFavorite_widget.dart';
import 'package:integrador/ui/pages/widgets/plant_widget.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  final List<FormModel> favoritedForms;
  const FavoritePage({Key? key, required this.favoritedForms});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    final formProvider = Provider.of<FormProvider>(context);
    debugPrint('Contenido de la lista de plantas favoritas: ${widget.favoritedForms}');
    debugPrint('Plantas del provider: ${formProvider.formList}');
    return Scaffold(
      body: widget.favoritedForms.isEmpty || !widget.favoritedForms.any((form) => form.isFavorated)
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
              "Your favorited Forms",
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
        height: MediaQuery.of(context).size.height * .5,
        child: ListView.builder(
          itemCount: widget.favoritedForms.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            final form = widget.favoritedForms[index];
            if (!form.isFavorated) {
              return SizedBox.shrink();
            }
            return FormWidget(
              formList: widget.favoritedForms,
              index: index,
              updateFavoriteStatus: (isFavorited) {
                setState(() {
                  formProvider.updateFormFavoriteStatus(form.id, isFavorited);
                });
              },
            );
          },
        ),
      ),
    );
  }
}
