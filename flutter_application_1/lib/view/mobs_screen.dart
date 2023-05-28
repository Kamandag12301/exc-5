import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/models/mobs.dart';
import 'package:flutter/material.dart';

import '../shared/firestore.dart';

class MobScreen extends StatefulWidget {
  const MobScreen({Key? key}) : super(key: key);

  @override
  State<MobScreen> createState() => _MobScreenState();
}

class _MobScreenState extends State<MobScreen> {
  FirestoreData fireData = FirestoreData();
  List<Mobs>? minecraftMobs;
  String error = "";

  @override
  void initState() {
    super.initState();
    fireData = FirestoreData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minecraft Mobs"),
      ),

      // You can use FutureBuilder here
      body: FutureBuilder<List<Mobs>?>(
        future: fireData.getMobs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Container(
              child: Text("Cannot fetch data due to error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => _buildMobTile(data[index]),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildMobTile(Mobs mobs) {
    return ListTile(
      leading: Image.network(mobs.image!),
      title: Text(mobs.name!),
      subtitle: Text(mobs.health!),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(mobs.biome!),
          Text(mobs.description!),
        ],
      ),
    );
  }
}
