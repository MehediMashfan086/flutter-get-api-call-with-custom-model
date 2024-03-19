import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Photos> photoList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http.get(Uri.parse(
      "https://jsonplaceholder.typicode.com/photos",
    ));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i["title"], url: i["url"], id: i["id"]);
        photoList.add(photos);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Custom Model",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                return ListView.builder(
                    itemCount: photoList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data![index].url.toString()),
                        ),
                        title: Text("Notes id: ${snapshot.data![index].id}"),
                        subtitle: Text(snapshot.data![index].title.toString()),
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}

class Photos {
  int id;
  String title, url;

  Photos({
    required this.id,
    required this.title,
    required this.url,
  });
}
