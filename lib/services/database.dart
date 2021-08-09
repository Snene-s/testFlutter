import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {


  Future<void> addData(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await Firestore.instance.collection("users").snapshots();
  }

  Future<void> addCardData(Map<String,String> cardData, String cardId) async {
    print(cardId);
    await Firestore.instance
        .collection("Card")
        .document(cardId)
        .setData(cardData)
        .catchError((e) {
      print(e);
    });
  }

  getCardData() async {
    return await Firestore.instance.collection("Card").snapshots();
  }
}
