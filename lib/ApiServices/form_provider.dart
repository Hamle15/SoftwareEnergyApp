import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:integrador/models/form.dart';

class FormProvider extends ChangeNotifier {
  List<FormModel> _formList = [];
  List<FormModel> get formList => _formList;

  Future<void> fetchForms(String email) async {
    final url = 'http://192.168.1.6:3000/api/form/getByEmail?email=$email';
    debugPrint('Fetching forms from URL: $url');
    try {
      final response = await http.get(Uri.parse(url));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> responseData = json.decode(response.body);
        debugPrint('Decoded response data: $responseData');
        if (responseData["ok"]) {
          List<dynamic> data = responseData["userForms"];
          _formList = data.map((item) => FormModel.fromJson(item)).toList();
          notifyListeners();
          debugPrint('Updated form list: $_formList');
        } else {
          debugPrint('Error in response data: ${responseData["message"]}');
          throw Exception('Error en la respuesta de la API: ${responseData["message"]}');
        }
      } else {
        debugPrint('Error: ${response.statusCode}');
        throw Exception('Error al cargar los datos: ${response.reasonPhrase}');
      }
    } catch (error) {
      debugPrint('Fetch error: $error');
      throw error;
    }
  }

  void updateFormFavoriteStatus(String id, bool isFavorited) {
    final formIndex = _formList.indexWhere((form) => form.id == id);
    if (formIndex != -1) {
      _formList[formIndex].isFavorated = isFavorited;
      notifyListeners();
    } else {
      debugPrint('Form with id $id not found.');
    }
  }

}
