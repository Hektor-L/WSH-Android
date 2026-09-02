import 'package:workservicehub_project/models/classes/user.dart';
import 'package:workservicehub_project/models/local_storage_service.dart';

class UserListController {
  static Future<void> insertUser(int id, String name, String email, String description, DateTime birthDate, String type) async {
    List<User> list = await LocalStorageService.loadUsers();
    list.add(User(id: id, name: name, email: email, description: description, birthDate: birthDate, type: type));
    await LocalStorageService.saveUsers(list);
  }
  static Future<void> deletePost(int id) async {
    List<User> list = await LocalStorageService.loadUsers();
    for(User u in list){
      if(u.id == id) {
        list.remove(u);
        break;
      }
    }
    await LocalStorageService.saveUsers(list);
  }
  static Future<void> updatePost(User user) async {
    List<User> list = await LocalStorageService.loadUsers();
    int index = 0;
    for(User u in list) {
      if (u.id == user.id) {
        list.removeAt(index);
        break;
      }
      index++;
    }
    list.add(user);
    await LocalStorageService.saveUsers(list);
  }
  static Future<User> findUser(int id) async {
    List<User> list = await LocalStorageService.loadUsers();
    return list.firstWhere((instance) => instance.id == id);
  }
  static Future<List<User>> listUsers() async {
    return await LocalStorageService.loadUsers();
  }
}