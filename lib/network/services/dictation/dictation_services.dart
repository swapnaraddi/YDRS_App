import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/network/models/dictation/dictations_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Get all dictations api service class
class AllDictationService {
  Future<Dictations> getDictations() async{
    try {
      var endpointUrl = ApiUrlConstants.dictations;
      Map<String, dynamic> queryParams = {
        'TranscriptionId': '5753',
        'AppointmentId': '34533',
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      print('requestUrl $requestUrl');
      final response = await http.get(Uri.encodeFull(requestUrl),
          headers: {"Accept": "application/json"});
      print('response' +response.body);
      if (response.statusCode == 200) {
        Dictations allDictations = parseAllDictations(response.body);
        print('dictations-- $allDictations');
        return allDictations;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Dictations parseAllDictations(String responseBody){
    final Dictations allDictations = Dictations.fromJson(json.decode(responseBody));
    print(allDictations);
    return allDictations;
  }
}

/// Get all previous dictations api service class
class AllPreviousDictationService {
  Future<Dictations> getAllPreviousDictations() async{
    try {
      var endpointUrl = ApiUrlConstants.allPreviousDictations;
      Map<String, dynamic> queryParams = {
        'EpisodeID': '39308',
        'AppointmentId': '34537',
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      print('requestUrl $requestUrl');
      final response = await http.get(Uri.encodeFull(requestUrl),
          headers: {"Accept": "application/json"});
      print('response' +response.body);
      if (response.statusCode == 200) {
        Dictations allPreviousDictations = parseAllPreviousDictations(response.body);
        print(allPreviousDictations);
        return allPreviousDictations;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Dictations parseAllPreviousDictations(String responseBody){
    final Dictations allPreviousDictations = Dictations.fromJson(json.decode(responseBody));
    print(allPreviousDictations);
    return allPreviousDictations;
  }
}

/// Get my previous dictations api service class
class MyPreviousDictationService {
  Future<Dictations> getMyPreviousDictations() async{
    try {
      var endpointUrl = ApiUrlConstants.myPreviousDictations;
      Map<String, dynamic> queryParams = {
        'EpisodeId': '39356',
        'AppointmentId': '33977',
        'LoggedInMemberId': '15',
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      print('requestUrl $requestUrl');
      final response = await http.get(Uri.encodeFull(requestUrl),
          headers: {"Accept": "application/json"});
      print('response' +response.body);
      if (response.statusCode == 200) {
        Dictations myPreviousDictations = parseMyPreviousDictations(response.body);
        print('dictations-- $myPreviousDictations');
        return myPreviousDictations;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Dictations parseMyPreviousDictations(String responseBody){
    final Dictations myPreviousDictations = Dictations.fromJson(json.decode(responseBody));
    print(myPreviousDictations);
    return myPreviousDictations;
  }
}