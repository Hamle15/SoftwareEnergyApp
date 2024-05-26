import 'package:integrador/models/formToGive.dart';

class FormModelToGive {
  String emailUser = "";
  String allDevicesNum1 = "";
  String deskCompNum2 = "";
  String hoursPerDayDeskComp3 = "";
  String avgYearsUsageDekComp4 = "";
  String numberServers5 = "";
  String avgHoursPerDayUsageServ6 = "";
  String avgYearsUsageServ7 = "";
  String numberLaptops8 = "";
  String avgHoursPerDayUsageLaptop9 = "";
  String avgYearsUsageLaptop10 = "";
  String energyConsumedByBranchW11 = "";

  FormModelToGive.fromJson(Map<String, dynamic> json) {
    emailUser = json["emailUser"] ?? "";
    allDevicesNum1 = json["allDevicesNum1"] ?? "";
    deskCompNum2 = json["deskCompNum2"] ?? "";
    hoursPerDayDeskComp3 = json["hoursPerDayDeskComp3"] ?? "";
    avgYearsUsageDekComp4 = json["avgYearsUsageDekComp4"] ?? "";
    numberServers5 = json["numberServers5"] ?? "";
    avgHoursPerDayUsageServ6 = json["avgHoursPerDayUsageServ6"] ?? "";
    avgYearsUsageServ7 = json["avgYearsUsageServ7"] ?? "";
    numberLaptops8 = json["numberLaptops8"] ?? "";
    avgHoursPerDayUsageLaptop9 = json["avgHoursPerDayUsageLaptop9"] ?? "";
    avgYearsUsageLaptop10 = json["avgYearsUsageLaptop10"] ?? "";
    energyConsumedByBranchW11 = json["energyConsumedByBranchW11"] ?? "";
  }
}
