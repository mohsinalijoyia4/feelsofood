import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ai/model/History.dart';
class HistoryViewModel with ChangeNotifier{

  HistoryViewModel(){
    fetchHistory();
  }
  List<HistoryModel> model = [];
  bool isLoading = true;
  setLoading(loading){
    isLoading = loading;
    notifyListeners();
  }

  // Decode string after retrieving from Firestore
  String decodeString(String encodedString) {
    String decodedString = utf8.decode(base64Decode(encodedString));
    return decodedString;
  }

  fetchHistory()async{
    setLoading(true);
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    await firebase.collection("users").doc(uid).collection("history").orderBy('timestamp', descending: true).get().then((value) {

      value.docs.map((e) {
        var body = decodeString(e.data()["response"]);
        model.add(HistoryModel(title: e.data()["recipeName"], description: body, imageUrl: e.data()["image"]));}).toList();
    }).catchError((e) {print(e);}).then((value) {
      setLoading(false);
    });
  }
}