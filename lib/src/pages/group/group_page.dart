import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GroupPage extends StatefulWidget {
  final String name;
  GroupPage({Key? key, required this.name}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  //instance of the socket io package
  //IO.Socket? socket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  void connect(){
    // socket = IO.io("http://localhost:3000"
    // //     <String,dynamic>{
    // //   "transports": ["websocket"],
    // //   "autoConnect": false,
    // // }
    //
    // );
    print("strting");
    IO.Socket socket = IO.io("http://localhost:3000",
        IO.OptionBuilder()
            .setTransports(['websocket'])
        // for Flutter or Dart VM// disable auto-connection// optional
            .build()
    );
    log(socket.toString());
    socket.connect();
    //socket!.connect();
    print("we are here");
    socket.onConnectError((data){
      log("something went Wrong");
      print(data.toString());
    });
    socket.onConnect((_){
      print("connected into frontend");
      socket.emit('sendMsg', 'test emit event');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Chat"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Type here ...",
                    border: OutlineInputBorder(
                      //borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 2)
                    )
                  ),
                )),
                IconButton(onPressed: (){}, icon: Icon(Icons.send,color: Colors.teal,))
              ],
            ),
          )
        ],
      ),
    );
  }
}
