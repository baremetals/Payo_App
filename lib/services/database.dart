import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:payo/models/transfers.dart';
import 'package:payo/models/user.dart';
import 'package:meta/meta.dart';
import 'package:payo/services/api_path.dart';
import 'package:payo/services/firestore_service.dart';
import 'auth.dart';

abstract class DatabaseService {
  Future<void> setTransfer(Transfer transfer);
  Stream<List<Transfer>> transferStream();
  Stream<Transfer> transfersStream({@required String transferId});
}

class FirestoreDatabase implements DatabaseService {
  FirestoreDatabase({@required this.uid, this.email}) : assert(uid != null);
  final String uid;
  final String email;

  final _service = FirestoreService.instance;
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final CollectionReference transferCollection =
      Firestore.instance.collection('transfers');

  Future<void> createUser(firstName, lastName, mobile, email) async {
    try {
      await userCollection.document(uid).setData({
        'firstName': firstName,
        'lastName': lastName,
        'mobile': mobile,
        'email': email
      });
    } catch (e) {
      return e.message;
    }
  }

  Future<void> createTransfer(
      receiverName,
      phoneNumber,
      sendingCurrency,
      receivingCurrency,
      paymentType,
      destination,
      from,
      amountReceived,
      amountSent,
      status,
      date) async {
    try {
      await Firestore.instance.collection("users").document(uid).collection("transfers").add({
        'receiverName': receiverName,
        'phoneNumber': phoneNumber,
        'sendingCurrency': sendingCurrency,
        'receivingCurrency': receivingCurrency,
        'paymentType': paymentType,
        'destination': destination,
        'from': from,
        'amountReceived': amountReceived,
        'amountSent': amountSent,
        'status': status,
        'date': date
      });
    } catch (e) {
      return e.message;
    }
  }

  Future<void> bankTransfer(
      receiverName,
      phoneNumber,
      sendingCurrency,
      receivingCurrency,
      paymentType,
      destination,
      from,
      amountReceived,
      amountSent,
      accountNumber,
      sortCode,
      bic,
      iban,
      status,
      date) async {
    try {
      await Firestore.instance.collection("users").document(uid).collection("transfers").add({
        'accountDetails': ({
          'accountNumber': accountNumber,
          'sortCode': sortCode,
          'bic': bic,
          'iban': iban,
      }),
        'receiverName': receiverName,
        'phoneNumber': phoneNumber,
        'sendingCurrency': sendingCurrency,
        'receivingCurrency': receivingCurrency,
        'paymentType': paymentType,
        'destination': destination,
        'from': from,
        'amountReceived': amountReceived,
        'amountSent': amountSent,
        'status': status,
        'date': date
      });
    } catch (e) {
      return e.message;
    }
  }

  Future<void> updateUserData(String firstName, String lastName, String email,
      String mobile, String profession) async {
    return await userCollection.document(uid).setData({
      firstName: firstName,
      lastName: lastName,
      'email': email,
      'mobile': mobile,
      'profession': profession,
    });
  }

  Future<void> updateUserDetails(
      String firstName, String lastName, String mobile, String email) async {
    return await userCollection.document(uid).updateData({
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'email': email,
    });
  }

  @override
  Future<void> setTransfer(Transfer transfer) async => await _service.setData(
        path: APIPath.transfer(uid, transfer.id),
        data: transfer.toMap(),
      );

  Stream<List<Transfer>> transferStream() => _service.collectionStream(
        path: APIPath.transfers(uid),
        builder: (data, documentId) => Transfer.fromMap(data, documentId),
      );

  // Stream<List<Transfer>> transferStream() {
  //   final path = APIPath.transfers(uid);
  //   final reference = Firestore.instance.collection(path);
  //   final snapshots = reference.snapshots();
  //   return snapshots.map((snapshot) => snapshot.documents
  //       .map(
  //         (snapshot) => Transfer.fromMap(snapshot.data, snapshot.documentID),
  //       )
  //       .toList());
  // }

  @override
  Stream<Transfer> transfersStream({@required String transferId}) =>
      _service.documentStream(
        path: APIPath.transfer(uid, transferId),
        builder: (data, documentId) => Transfer.fromMap(data, documentId),
      );

  // User list from snapshot
  // ignore: non_constant_identifier_names
  List<User> _UserListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return User(
          uid: uid,
          firstName: doc.data['firstName'] ?? '',
          lastName: doc.data['lastName'] ?? '',
          email: doc.data['email'] ?? '',
          mobile: doc.data['mobile'] ?? '');
    }).toList();
  }

  // user data from snapshots
  UserData _userFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstName: snapshot.data['firstName'],
      lastName: snapshot.data['lastName'],
      email: snapshot.data['email'],
      mobile: snapshot.data['mobile'],
    );
  }

  // Transfer _transferFromSnapshot(DocumentSnapshot snapshot) {
  //   return Transfer(
  //       id: snapshot.data['transferId'],
  //       receiverName: snapshot.data['receiverName'],
  //       currency: snapshot.data['currency'],
  //       paymentType: snapshot.data['paymentType'],
  //       destination: snapshot.data['destination'],
  //       from: snapshot.data['from'],
  //       fees: snapshot.data['fees'],
  //       amountSent: snapshot.data['amountSent'],
  //       status: snapshot.data['status']
  //   );
  // }

  // get users stream
  Stream<List<User>> get users {
    return userCollection.snapshots().map(_UserListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get user {
    return userCollection.document(uid).snapshots().map(_userFromSnapshot);
  }

  // Stream<Transfer> get transfers {
  //   return transferCollection.document(uid).snapshots()
  //       .map(_transferFromSnapshot);
  // }

  // Future getUser(String uid) async {
  //   try {
  //     var tranferData = await transferCollection.document(id).get();
  //     return User.fromData(userData.data);
  //   } catch (e) {
  //     return e.message;
  //   }
  // }

}
