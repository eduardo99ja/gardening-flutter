import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gardening/src/models/user.dart';

class UserProvider {
  late CollectionReference _ref;

  UserProvider() {
    _ref = FirebaseFirestore.instance.collection('Users');
  }

  Future? create(User user) {
    return _ref
        .add(user.toJson())
        .then((value) => print('User added'))
        .catchError((error) => print('Failed to add user: $error'));
  }
}
