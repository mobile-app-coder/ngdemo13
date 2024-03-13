import 'package:flutter/material.dart';
import 'package:ngdemo13/models/post_model.dart';
import 'package:ngdemo13/services/log_service.dart';
import 'package:ngdemo13/services/network_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String response = "no data";

  @override
  void initState() {
    super.initState();
    deletePost();
  }

  loadPosts() async {
    var response = await Network.GET(Network.API_POST_LIST, {});

    LogService.d(response!);
  }

  createPost() async {
    Post post = Post(id: 1, title: "Networking", body: "lesson", userId: 1);
    var response =
        await Network.POST(Network.API_POST_CREATE, Network.paramsCreate(post));
    LogService.d(response!);

    setState(() {
      this.response = response;
    });
  }

  updatePost() async {
    Post post = Post(id: 1, title: "Networking", body: "lesson", userId: 1);
    var response = await Network.PUT(
        Network.API_POST_UPDATE + post.id.toString(),
        Network.paramsUpdate(post));
    LogService.d(response!);

    setState(() {
      this.response = response;
    });
  }

  deletePost() async {
    Post post = Post(id: 1, title: "Networking", body: "lesson", userId: 1);
    var response = await Network.DEL(
        Network.API_POST_UPDATE + post.id.toString(), Network.paramsEmpty());
    LogService.d(response!);

    setState(() {
      this.response = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Networking",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text(
          response,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
