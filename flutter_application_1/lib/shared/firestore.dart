// Class for Firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/mobs.dart';
import 'dart:async';

class FirestoreData {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Create functions to fetch data
  Future<List<Mobs>?> getMobs() async {
    try {
      CollectionReference mobsCollection = db.collection("Minecraft Mobs");
      List<Mobs> myMobs = List.empty(growable: true);

      // fetch data
      QuerySnapshot snapshot = await mobsCollection.get();
      List<QueryDocumentSnapshot> mobsList = snapshot.docs;

      for (DocumentSnapshot snap in mobsList) {
        // transform the data
        Mobs temp = Mobs(snap.id, snap.get("name"), snap.get("health"),
            snap.get("biome"), snap.get("description"), snap.get("image"));
        myMobs.add(temp);
      }
      // print(plantList);

      return myMobs;
    } catch (error) {
      // print(error);
      return null;
    }
  }
}
