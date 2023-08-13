import 'package:cloud_firestore/cloud_firestore.dart';

class MyFirebase {
  static var ref = FirebaseFirestore.instance;
  static var storeCollection = FirebaseFirestore.instance.collection('store');
  static var versionCollection =
      FirebaseFirestore.instance.collection('version');

 Future<String> checkForNewVersion() async {
    return await versionCollection
        .doc('version')
        .get()
        .then((value) => value["version"]);
  }

  getNewVersionLink() async {
    return await versionCollection
        .doc('version')
        .get()
        .then((value) => value["link"]);
  }

  //checking if this use already exist in the backend.
  Future<bool> isUserAlreadyExist(String regdNo) async {
    return await ref
        .collection('student')
        .doc(regdNo)
        .get()
        .then((value) => value.exists);
  }

  //this is to save regdno with imei number
  Future<void> saveRegdNoWithImei(String regdNo, String imei) async {
    await ref
        .collection('validate')
        .doc(regdNo)
        .set({"regdNo": regdNo, "imei": imei}).then((value) {
      ref
          .collection('student')
          .doc(regdNo)
          .set({"regdNo": regdNo}).then((value) {
        //save this imei in imei collection
        ref.collection('imei').doc(imei).set({"regdNo": regdNo});
      });
    });
  }

  Future<bool> isThisImeiAlreadyExist(String imei) async {
    return ref.collection('imei').doc(imei).get().then((value) => value.exists);
  }

  Future<String> checkRegdNoWithImei(String regdNo) async {
    return ref
        .collection('validate')
        .doc(regdNo)
        .get()
        .then((value) => value["imei"]);
  }
}
