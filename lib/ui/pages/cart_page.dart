import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:integrador/ApiServices/api_form.dart';
import 'package:integrador/constants.dart';
import 'package:integrador/models/form.dart';
import 'package:integrador/ui/pages/widgets/text_field_custom.dart';

class DynamicForm extends StatefulWidget {
  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  List<TextEditingController> controllers =
      List.generate(11, (index) => TextEditingController());
  int _currentPage = 0;
  final int _totalPages = 3;

  final List<IconData> icons = [
    Icons.email,
    Icons.devices,
    Icons.computer,
    Icons.timer,
    Icons.history,
    Icons.sensor_door_rounded,
    Icons.av_timer,
    Icons.laptop,
    Icons.schedule,
    Icons.update,
    Icons.energy_savings_leaf,
    Icons.sync
  ];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      int totalDevices = int.parse(controllers[1].text);
      int deskCompNum2 = int.parse(controllers[2].text);
      int numberServers5 = int.parse(controllers[5].text);
      int numberLaptops8 = int.parse(controllers[8].text);

      int totalSum = deskCompNum2 + numberServers5 + numberLaptops8;

      if (totalSum != totalDevices) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: los dispositivos no coinciden')),
        );
        return;
      }
      Map<String, dynamic> formDataJson = {
        "emailUser": controllers[0].text,
        "allDevicesNum1": controllers[1].text,
        "deskCompNum2": controllers[2].text,
        "hoursPerDayDeskComp3": controllers[3].text,
        "avgYearsUsageDekComp4": controllers[4].text,
        "numberServers5": controllers[5].text,
        "avgHoursPerDayUsageServ6": controllers[6].text,
        "avgYearsUsageServ7": controllers[7].text,
        "numberLaptops8": controllers[8].text,
        "avgHoursPerDayUsageLaptop9": controllers[9].text,
        "avgYearsUsageLaptop10": controllers[10].text,
        "energyConsumedByBranchW11": controllers[11].text
      };

      FormModel formData = FormModel.fromJson(formDataJson);
      print(formDataJson);

      await ApiService.sendData(formData).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Datos enviados correctamente')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al enviar los datos: $error')),
        );
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_totalPages, (index) => buildIndicator(index)),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Center(
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
                    return buildPage(index);
                  },
                  ),
                ),
              ),
            ),

          ],
        ),


    );
  }


  Widget buildPage(int pageIndex) {
    bool isLastPage = pageIndex == (_totalPages - 1);

    int startIndex = pageIndex * 4;
    return  // Centra el contenido del ListView
      ListView(

        children: [
          ...List.generate(
            4,
                (index) {
              if (startIndex + index < controllers.length) {
                return Padding(
                  padding: EdgeInsets.only(top: 15,right: 10, left:10),
                    child: TextFormField(
                      controller: controllers[startIndex + index],
                      decoration: InputDecoration(
                        labelText: getPageLabel(startIndex + index),
                        hintText: getPageHint(startIndex + index),
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Constants.blackColor,),
                        prefixIcon: Icon(icons[startIndex + index], color: Constants.primaryColor,),
                        filled: true,
                        fillColor: Constants.primaryColor.withOpacity(.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 26.0, horizontal: 12.0),

                      ),
                    ),

                );
              } else {
                return Container();
              }
            },
          ),
          if (isLastPage)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _submitForm,
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
      0: [
        'Número de Teléfono',
        '20',
        'Correo Electrónico',
        'Dirección',
        'Ocupación'
      ],
      1: [
        'Correo Electrónico',
        'Dirección',
        'Ocupación',
        'Número de Teléfono',
        'Nombre'
      ],
      2: [
        'Dirección',
        'Ocupación',
        'Número de Teléfono',
        'Nombre',
        'Correo Electrónico'
      ],
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
      0: ['Email', 'Devices', 'Numero de computadores', 'Horas en el computador'],
      1: [
        'Tiempo promedio de años de los computadores',
        'Numero de servers',
        'Horas en los servers',
        'Tiempo promedio de años en de los severs'
      ],
      2: [
        'Numero de laptops',
        'Horas en las laptops',
        'Timpo promedio de añs en las laptops',
        'Energia usada total'
      ],
    };
    if (pageLabels.containsKey(_currentPage)) {
      List<String> labels = pageLabels[_currentPage]!;
      return labels[index % labels.length];
    } else {
      return '';
    }
  }
}
