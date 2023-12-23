import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_art/screens/profile_pic_page.dart';
import 'package:my_art/ui_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseFirestore db;

  late TextEditingController titleController = TextEditingController();
  late TextEditingController descController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    db = FirebaseFirestore.instance;
    //
    // db.collection("notes").doc("Smhf2n38drrNauuH2ikj").update({});
    //
    // db.collection("notes").doc("Smhf2n38drrNauuH2ikj").delete()
    //     .then((value) {});

    db.collection("notes").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("To Do",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        actions: [
          ProfilePicPage(),
        ],
      ),
      body: StreamBuilder(
        stream: db.collection("notes").snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  var eachDocs = snapshot.data!.docs[index].data();
                  var eachid = snapshot.data!.docs[index].id;
                  return InkWell(
                    onTap: () {
                      UpdateData(eachid,eachDocs["title"],eachDocs["desc"]);
                    },
                    child: Card(

                      child: ListTile(
                        title: Text(
                          "${eachDocs["title"]}",
                          style:const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${eachDocs["desc"]}",
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: InkWell(
                            onTap: () {
                              deleteData(eachid);
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    ),
                  );
                });
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 370,
                        child: TextFormField(
                          controller: titleController,
                          style: const TextStyle(fontSize: 14),
                          cursorColor: Colors.purple,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            focusedBorder:const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple, width: 2)),
                            enabledBorder:const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: 'Title',
                            hintStyle: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 370,
                        child: TextFormField(
                          controller: descController,
                          style: const TextStyle(fontSize: 14),
                          cursorColor: Colors.purple,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            focusedBorder:const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple, width: 2)),
                            enabledBorder:const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: 'Title',
                            hintStyle: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          child:const Text("Add"),
                          onPressed: () {
                            db.collection("notes").add({
                              "title": titleController.text,
                              "desc": descController.text,
                              // "type": 2,
                            }).then((value) {
                              print("Note Added : ${value.id}");
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future UpdateData(String id,String mTitle,String mDesc) {
    titleController.text = mTitle;
    descController.text = mDesc;
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                SizedBox(
                  width: 370,
                  child: TextFormField(
                    controller: titleController,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'Title',
                      hintStyle:
                          const TextStyle(fontSize: 14, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 370,
                  child: TextFormField(
                    controller: descController,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'Title',
                      hintStyle:
                          const TextStyle(fontSize: 14, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    child: Text("Update"),
                    onPressed: () {
                      db.collection("notes").doc(id).update({
                        "title": titleController.text,
                        "desc": descController.text,
                        "type": 2,
                      });
                      Navigator.pop(context);
                      titleController.clear();
                      descController.clear();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> deleteData(String itemId) async {
    await db.collection("notes").doc(itemId).delete();
  }
}
