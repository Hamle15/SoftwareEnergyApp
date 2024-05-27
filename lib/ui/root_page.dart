 import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:integrador/ApiServices/form_provider.dart';
import 'package:integrador/constants.dart';
import 'package:integrador/models/form.dart';
import 'package:integrador/models/plants.dart';
import 'package:integrador/ui/pages/cart_page.dart';
import 'package:integrador/ui/pages/favorite_page.dart';
import 'package:integrador/ui/pages/home_page.dart';
import 'package:integrador/ui/pages/profile_page.dart';
import 'package:integrador/ui/scan_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<FormModel> favorities = [];
  List<Plant> myCart = [];
  int _bottomNavIndex = 0;

  // List of pages
  List<Widget> _widgetOptions(){
    return [
      const HomePage(),
      FavoritePage(favoritedForms: favorities, ),
      DynamicForm(),
      const ProfilePage(),
    ];
  }

  // List of pages Icons
  List<IconData> iconList = [
    Icons.home,
    Icons.favorite,
    Icons.edit,
    Icons.person
  ];

  // List of the pages titles
  List<String> titleList = [
    'Home',
    'Favorite',
    'Form',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(titleList[_bottomNavIndex], style: TextStyle(
              color: Constants.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),),
            Icon(Icons.notifications, color: Constants.blackColor, size: 30.0)
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, PageTransition(child: const ScanPage(), type: PageTransitionType.bottomToTop, duration: const Duration(milliseconds: 700)));
        },
        // Todo: Aggregate scanner in the floatingButton
        shape: const CircleBorder(),
        backgroundColor: Constants.primaryColor,
        child: Image.asset('assets/images/code-scan-two.png', height: 30.0,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashColor: Constants.primaryColor,
        activeColor: Constants.primaryColor,
        inactiveColor: Colors.black.withOpacity(.5),
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index){
          setState(() {
            _bottomNavIndex = index;
            final formProvider = Provider.of<FormProvider>(context, listen: false);
            favorities = formProvider.formList.where((form) => form.isFavorated).toList();
          });
        },
      ),
    );
  }
}
