import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Show_Users.dart';
import 'package:flutter/material.dart';
import 'user_model.dart';

class UpdateUser extends StatelessWidget {
  final User user;
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final TextEditingController controllerAge = TextEditingController();
  final TextEditingController controllerContact = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();

  final FocusNode focusNode = FocusNode();

  UpdateUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    controllerName.text = user.name;
    controllerLastName.text = user.lastname;
    controllerAge.text = '${user.age}';
    controllerContact.text = '${user.contact}';
    controllerEmail.text = user.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update User"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            getMyField(
                focusNode: focusNode,
                hintText: 'First Name',
                textInputType: TextInputType.text,
                controller: controllerName),
            getMyField(
                hintText: 'Last  Name',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                  ),
                  onPressed: () {
                    User updateUser = User(
                        id: user.id,
                        name: controllerName.text,
                        lastname: controllerLastName.text,
                        age: int.parse(controllerAge.text),
                        email: controllerEmail.text,
                        contact: int.parse(controllerContact.text));
                    final reference =
                        FirebaseFirestore.instance.collection('users');
                    reference
                        .doc(updateUser.id)
                        .update(updateUser.toJson())
                        .whenComplete(() => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ShowUser())));
                  },
                  child: const Text("Update"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                  ),
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
              ],
            )
          ],
        ),
      ),
    );
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
