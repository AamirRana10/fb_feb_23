import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/update_user.dart';
import 'package:firebase_app/user_model.dart';
import 'package:flutter/material.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({super.key});

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //             builder: (BuildContext context) => const HomePage()),
      //       );
      //     },
      //     child: const Icon(Icons.add)),
      appBar: AppBar(
        title: const Text("Users"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _reference.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong!');
          }
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            List<User> users = documents
                .map((e) => User(
                    id: e["id"],
                    name: e['name'],
                    lastname: e['lastname'],
                    age: e['age'],
                    contact: e['contact'],
                    email: e['email']))
                .toList();
            return buildUser(users);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildUser(users) => ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => Card(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ListTile(
                  tileColor: Colors.white38,
                  title: Text(users[index].name),
                  leading: CircleAvatar(
                    child: Text('${users[index].age}'),
                  ),
                  subtitle: Text('${users[index].id}'),
                  trailing: SizedBox(
                    width: 60,
                    child: Row(
                      children: [
                        InkWell(
                            child: Icon(
                              Icons.edit,
                              color: Colors.lightBlue.withOpacity(0.75),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateUser(user: users[index]),
                                  ));
                            }),
                        InkWell(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red.withOpacity(0.75),
                          ),
                          onTap: () {
                            _reference.doc(users[index].id).delete();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ShowUser()));
                          },
                        ),
                      ],
                    ),
                  )),
            ),
          ));
}
