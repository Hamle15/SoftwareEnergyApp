import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integrador/constants.dart';
import 'package:integrador/ui/pages/widgets/text_field_custom.dart';


class DynamicForm extends StatefulWidget {
  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  List<TextEditingController> controllers = List.generate(4, (index) => TextEditingController());
  int _currentPage = 0;
  int _totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_totalPages, (index) => buildIndicator(index)),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _totalPages,
                onPageChanged: (int page){
                  setState(() {
                    _currentPage = page;
                  });
                }, itemBuilder: (BuildContext context, int index){
                  return buildPage(index, const Icon(Icons.numbers, color: Colors.grey));
              },
              ),
            ),
          ),
          
          
                ],
              ),
        ),

    );
  }


  Widget buildPage(int pageIndex, Widget prefixIcon) {
    // Verifica si estamos en la última página del formulario
    bool isLastPage = pageIndex == (_totalPages - 1);
    return ListView(
      children: [
        ...List.generate(
          4,
              (index) => Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controllers[index],
              decoration: InputDecoration(
                labelText: getPageLabel(index),
                hintText: getPageHint(index),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
        // Agrega el botón "Enviar" solo en la última página
        if (isLastPage)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _calculateTotalDevices;
              },
              child: Text('Enviar'),
            ),
          ),
      ],
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 10.0,
      height: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 30),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.blue : Colors.grey,
      ),

    );
  }

  String getPageHint(int index) {
    Map<int, List<String>> pageHints = {
      0: ['Número de Teléfono', 'Nombre', 'Correo Electrónico', 'Dirección', 'Ocupación'],
      1: ['Correo Electrónico', 'Dirección', 'Ocupación', 'Número de Teléfono', 'Nombre'],
      2: ['Dirección', 'Ocupación', 'Número de Teléfono', 'Nombre', 'Correo Electrónico'],

    };
    if (pageHints.containsKey(_currentPage)) {
      List<String> hints = pageHints[_currentPage]!;
      return hints[index % hints.length];
    } else {
      return '';
    }
  }

  String getPageLabel(int index) {
    Map<int, List<String>> pageLabels = {
      0: ['Devices', 'Nombre', 'Correo', 'Dirección'],
      1: ['Devices2', 'Dirección', 'Ocupación', 'Teléfono'],
      2: ['devices3', 'Ocupación', 'Teléfono', 'Nombre'],
    };
    if (pageLabels.containsKey(_currentPage)) {
      List<String> labels = pageLabels[_currentPage]!;
      return labels[index % labels.length];
    } else {
      return '';
    }
  }

  void _calculateTotalDevices() {
    int totalDevices = int.parse(controllers[0].text);
    int deskCompNum2 = int.parse(controllers[1].text);
    int numberServers5 = int.parse(controllers[4].text);
    int numberLaptops8 = int.parse(controllers[7].text);

    int totalSum = totalDevices + deskCompNum2 + numberServers5 + numberLaptops8;

    if(totalSum != totalDevices){
      print("Error los dispotivos no coiciden");
    }
    print('El total de dispositivos es: $totalSum');
  }
}
