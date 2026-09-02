import 'package:workservicehub_project/models/classes/auth.dart';
import 'package:workservicehub_project/models/local_storage_service.dart';
import 'package:bcrypt/bcrypt.dart';

class AuthController {
  static Future<void> storeAuth(String name, String email, String authToken) async{
    Auth auth = Auth(name: name, email: email, password: '', authToken: authToken);
    //salvando produto na lista persistida
    await LocalStorageService.storeAuth(auth);
  }
  static Future<void> unloadAuth() async{
    await LocalStorageService.unloadAuth();
  }

  /**
   * função fake de autenticação na api de forma positiva
   */
  static Future <bool> verificaAutorizacaoOnline(Auth auth) async{

    //faço a chamada à API enviando o json do meu objeto de autorizacao
    //envio este json para a API para obter o token
    //json.encode(auth.toMap());

    //simula o retorno da api
    //BCrypt.checkpw(auth.password, [[API hashed password]])
    if(auth.name.isNotEmpty && auth.email.isNotEmpty && auth.password.isNotEmpty) {
      Auth authRetornoAPI = Auth(
          name: auth.name,
          email: auth.email,
          password: '',
          authToken: BCrypt.hashpw(auth.password, BCrypt.gensalt())
      );
      storeAuth(
          authRetornoAPI.name, authRetornoAPI.email, authRetornoAPI.authToken);
      print('autorização gravada!\nUsuário: ${authRetornoAPI.name}\nToken: ${authRetornoAPI.authToken}');
      return true;
    }else{
      return false;
    }
  }

  static Future <bool> verificaAutorizacaoOffline() async{
    Auth? auth =  await LocalStorageService.loadAuth();
    if(auth==null) return false;
    return true;
  }
}