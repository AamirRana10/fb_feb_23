import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Show_Users.dart';
import 'package:firebase_app/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controllerName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerContact = TextEditingController();
  final controllerEmail = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          getMyField(
              focusNode: focusNode,
              hintText: 'Name',
              textInputType: TextInputType.text,
              controller: controllerName),
          getMyField(
              hintText: 'Last Name',
              textInputType: TextInputType.text,
              controller: controllerLastName),
          getMyField(
              hintText: 'Age',
              textInputType: TextInputType.number,
              controller: controllerAge),
          getMyField(
              hintText: 'Contact',
              textInputType: TextInputType.number,
              controller: controllerContact),
          getMyField(
              hintText: 'Email',
              textInputType: TextInputType.text,
              controller: controllerEmail),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  User user = User(
                    name: controllerName.text,
                    age: int.parse(controllerAge.text),
                    lastname: controllerLastName.text,
                    contact: int.parse(controllerContact.text),
                    email: controllerEmail.text,
                  );
                  createUser(user, context);
                },
                child: const Text("Add"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  controllerName.text = '';
                  controllerLastName.text = '';
                  controllerAge.text = '';
                  controllerContact.text = '';
                  controllerEmail.text = '';
                  focusNode.requestFocus();
                },
                child: const Text("Reset"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const ShowUser()),
                  );
                },
                child: const Text("Show Users"),
              ),
            ],
          )
        ],
      ),
    );
  }

  //To create users in firebase database
  void createUser(User user, BuildContext context) {
    final docUser = FirebaseFirestore.instance.collection("users").doc();
    user.id = docUser.id;
    final data = user.toJson();

    //create document and write data to firebase

    docUser.set(data).whenComplete(() => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const ShowUser())));
  }

  getMyField(
      {required String hintText,
      TextInputType textInputType = TextInputType.name,
      required TextEditingController controller,
      FocusNode? focusNode}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: "Enter $hintText",
          labelText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
        ),
      ),
    );
  }
}
