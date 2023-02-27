import 'package:chat_application/src/pages/group/group_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Group Chat App"),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
            onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Please Enter Your Name"),
                      content: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: nameController,

                          //validator is trigger out using global Key
                          validator: (value) {
                            if (value == null || value.length < 3) {
                              return "User Must Have Proper Name";
                            }
                            return null;
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              nameController.clear(); //it will remove the text
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.green),
                            )),
                        TextButton(
                            onPressed: () {

                              //its check the currentState of Validation
                              if (formKey.currentState!.validate()) {
                                String name = nameController.text;
                                nameController.clear();
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GroupPage(name: name,)));
                              }
                            },
                            child: Text(
                              "Enter",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.blue),
                            )),
                      ],
                    )),
            child: Text(
              "Initiate Group chat",
              style: TextStyle(color: Colors.teal, fontSize: 16),
            )),
      ),
    );
  }
}
