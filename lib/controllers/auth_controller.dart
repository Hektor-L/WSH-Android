import 'package:dio/dio.dart';
import 'package:workservicehub_project/models/classes/auth.dart';
import 'package:workservicehub_project/models/local_storage_service.dart';
import 'package:workservicehub_project/models/web_storage_service.dart';
import 'package:workservicehub_project/views/splash1.dart';

class AuthController {
  static String loginUrl = "http://127.0.0.1:8000/api/login";
  static Future<void> storeAuth(int id, String name, String email, String authToken, String tokenType, String userType, String description, DateTime birthDate, DateTime createdAt) async{
    Auth auth = Auth(id: id, name: name, email: email, token: authToken, tokenType: tokenType, type: userType, description: description, birthDate: birthDate, createdAt: createdAt);
    //salvando produto na lista persistida
    await LocalStorageService.storeAuth(auth);
  }
  static Future<void> unloadAuth() async{
    await LocalStorageService.unloadAuth();
  }
  static Future <bool> verifyAuthOnline(String email, String password) async{
    Response resp = await WebStorageService().requestLogin(email, password);
    if(resp.data['data'] != null) {
      LocalStorageService.storeAuth(Auth.fromMap(resp.data['data']));
      loginData = Auth.fromMap(resp.data['data']);
      return true;
    } else {return false;}
  }
  static Future <bool> verifyAuthOffline() async{
    Auth? auth =  await LocalStorageService.loadAuth();
    if(auth==null) return false;
    return true;
  }
}