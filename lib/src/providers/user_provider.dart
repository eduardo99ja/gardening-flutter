import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gardening/src/models/user.dart';
import 'package:gardening/src/providers/auth_provider.dart';

class UserProvider {
  late CollectionReference _ref;

  late AuthProvider _authProvider;
  UserProvider() {
    _ref = FirebaseFirestore.instance.collection('Users');
    _authProvider = new AuthProvider();
  }

  Future? create(User user) {
    return _ref
        .add(user.toJson())
        .then((value) => print('User added'))
        .catchError((error) => print('Failed to add user: $error'));
  }

  Future<User?> getUser(String email) async {
    User? user;
    await _ref.where('email', isEqualTo: email).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        user = User(
            email: doc['email'],
            username: doc['username'],
            name: doc['name'],
            lastname: doc['lastname'],
            isAdmin: doc['isAdmin'],
            image: doc['image'],
            id: _authProvider.getUser().uid);
      });
      print(user?.lastname);
    });
    return user;
  }
}
