import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Opcion 1', votes: 5),
    Band(id: '2', name: 'Opcion 2', votes: 15),
    Band(id: '3', name: 'Opcion 3', votes: 25),
    Band(id: '4', name: 'Opcion 4', votes: 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'BandNames',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple.shade800,
          elevation: 1,
        ),
        body: ListView.builder(
            itemCount: bands.length,
            itemBuilder: (context, i) => _bandTile(bands[i])
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon( Icons.add ),
          elevation: 1,
          onPressed: addNewBand,
        ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ) {
        print('${direction}');
        print('ID: ${ band.id }');
        // TODO: llamar al borrado del server
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red, 
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete_forever, color: Colors.white,),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: TextStyle( fontSize: 20 ),),
        onTap: () {
          print(band.name);
        },
      )
    );
  }

  // Agregar nuevo band en mensaje de dialogo
  addNewBand() {
    final textController = new TextEditingController();

  if (Platform.isAndroid) {
    // Android
    return showDialog(
      context: context,
      builder: ( context ) {
        return AlertDialog(
          title: Text('New band name:'),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('Add'),
              elevation: 5,
              textColor: Colors.purple[700],
              onPressed: () => addBandToList(textController.text)
            ),
            MaterialButton(
              child: Text('Cancel'),
              elevation: 5,
              textColor: Colors.purple[700],
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      }
    );
  } 

  // iOS
  showCupertinoDialog(
    context: context, 
    builder: ( _ ) {
      return CupertinoAlertDialog(
        title: CupertinoTextField(
          controller: textController,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Add'),
            onPressed: () => addBandToList(textController.text),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    }
  );
  }


  void addBandToList(String name) {

    print(name);

    if (name.length > 1) {
      this.bands.add( Band(id: DateTime.now().toString(), name: name, votes: 0));
      
      setState(() {
        
      });
    }

    Navigator.pop(context);
  }
}
