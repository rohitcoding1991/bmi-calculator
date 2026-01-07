import 'package:bmi_calculator/services/firebase/FirebaseDBService.dart';
import 'package:bmi_calculator/services/localData/AppData.dart';
import 'package:bmi_calculator/services/localData/SharedPref.dart';

import 'AuthRepo.dart';

class AuthRepoImplementation extends AuthRepo {
  final _userCollection = FirebaseDBService('user', 'user');

  @override
  void logout() {
    SharedPref.logout();
    return;
  }

  @override
  Future<bool> updateProfile({required String name}) async{
    try{
      await _userCollection.update(AppData.uid!, {
        'name': name
      });
      return true;
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<String> login(
      {required String email, required String password}) async {
    try {
      final checkDoc = await _userCollection.checkIfDocExist('email', email);

      if (checkDoc.size > 0) {
        final snap = checkDoc.docs[0];

        final data = snap.data() as Map<String, dynamic>;
        if (data['password'] == password) {
          SharedPref.setUid(snap.id);
          return snap.id;
        } else {
          throw 'Failed to login! wrong credentials';
        }
      } else {
        final snap =
            await _userCollection.add({'email': email, 'password': password});
        SharedPref.setUid(snap.id);
        return snap.id;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String,dynamic>> getProfile() async {
    try {
      final doc = await _userCollection.getDoc(AppData.uid!);
      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String,dynamic>;
        return data;
      } else {
        throw 'Data not found';
      }
    } catch (e) {
      rethrow;
    }
  }
}
