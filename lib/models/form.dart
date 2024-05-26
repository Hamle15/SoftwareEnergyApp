import 'dart:convert';

class FormModel {
  String id;
  String emailUser;
  int allDevicesNum1;
  int deskCompNum2;
  int hoursPerDayDeskComp3;
  int avgYearsUsageDekComp4;
  int numberServers5;
  int avgHoursPerDayUsageServ6;
  int avgYearsUsageServ7;
  int numberLaptops8;
  int avgHoursPerDayUsageLaptop9;
  int avgYearsUsageLaptop10;
  int energyConsumedByBranchW11;
  int percResult;
  bool isFavorated;
  DateTime created_at;



  FormModel({
    required this.id,
    required this.emailUser,
    required this.allDevicesNum1,
    required this.deskCompNum2,
    required this.hoursPerDayDeskComp3,
    required this.avgYearsUsageDekComp4,
    required this.numberServers5,
    required this.avgHoursPerDayUsageServ6,
    required this.avgYearsUsageServ7,
    required this.numberLaptops8,
    required this.avgHoursPerDayUsageLaptop9,
    required this.avgYearsUsageLaptop10,
    required this.energyConsumedByBranchW11,
    required this.percResult,
    required this.isFavorated,
    required this.created_at,


  });

  FormModel.fromJson(Map<String, dynamic> json)
      : id = json["_id"],
        emailUser = json["emailUser"],
        allDevicesNum1 = json["allDevicesNum1"],
        deskCompNum2 = json["deskCompNum2"],
        hoursPerDayDeskComp3 = json["hoursPerDayDeskComp3"],
        avgYearsUsageDekComp4 = json["avgYearsUsageDekComp4"],
        numberServers5 = json["numberServers5"],
        avgHoursPerDayUsageServ6 = json["avgHoursPerDayUsageServ6"],
        avgYearsUsageServ7 = json["avgYearsUsageServ7"],
        numberLaptops8 = json["numberLaptops8"],
        avgHoursPerDayUsageLaptop9 = json["avgHoursPerDayUsageLaptop9"],
        avgYearsUsageLaptop10 = json["avgYearsUsageLaptop10"],
        energyConsumedByBranchW11 = json["energyConsumedByBranchW11"],
        percResult = json["percResult"],
        isFavorated = json["isFavorated"],
        created_at = DateTime.parse(json["created_at"]);




  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "emailUser": emailUser,
      "allDevicesNum1": allDevicesNum1,
      "deskCompNum2": deskCompNum2,
      "hoursPerDayDeskComp3": hoursPerDayDeskComp3,
      "avgYearsUsageDekComp4": avgYearsUsageDekComp4,
      "numberServers5": numberServers5,
      "avgHoursPerDayUsageServ6": avgHoursPerDayUsageServ6,
      "avgYearsUsageServ7": avgYearsUsageServ7,
      "numberLaptops8": numberLaptops8,
      "avgHoursPerDayUsageLaptop9": avgHoursPerDayUsageLaptop9,
      "avgYearsUsageLaptop10": avgYearsUsageLaptop10,
      "energyConsumedByBranchW11": energyConsumedByBranchW11,
      "percResult": percResult,
      "isFavorated": isFavorated,
      "created_at": created_at,
    };
  }
}
