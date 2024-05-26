import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:integrador/ApiServices/form_provider.dart';
import 'package:integrador/models/form.dart';
import 'package:integrador/models/formToGive.dart';
import 'package:provider/provider.dart';

class ApiService {
  static Future<void> sendData(FormModelToGive formData) async {
    try {
      var url = Uri.parse("http://192.168.1.6:3000/api/form/info");

      var response = await http.post(url, body: {
        'emailUser': formData.emailUser,
        'allDevicesNum1': formData.allDevicesNum1,
        'deskCompNum2': formData.deskCompNum2,
        'hoursPerDayDeskComp3': formData.hoursPerDayDeskComp3,
        'avgYearsUsageDekComp4': formData.avgYearsUsageDekComp4,
        'numberServers5': formData.numberServers5,
        'avgHoursPerDayUsageServ6': formData.avgHoursPerDayUsageServ6,
        'avgYearsUsageServ7': formData.avgYearsUsageServ7,
        'numberLaptops8': formData.numberLaptops8,
        'avgHoursPerDayUsageLaptop9': formData.avgHoursPerDayUsageLaptop9,
        'avgYearsUsageLaptop10': formData.avgYearsUsageLaptop10,
        'energyConsumedByBranchW11': formData.energyConsumedByBranchW11,
      });

      String rawResponse = utf8.decode(response.bodyBytes);
      print(rawResponse);

    } catch (ex) {
      // Manejo de errores
      String msg = ex.toString();
      print("Holiii entra");
      print(msg);
    }
  }
}
