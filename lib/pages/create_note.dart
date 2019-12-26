import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NewNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewNoteState();
}

class NewNoteState extends State<NewNote> {
  ZefyrController _controller;
  String _title;
  String _body;

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    final document = _loadDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black87, //change your color here
          ),
          elevation: 0.0,
          title: Text("New Note", style: TextStyle(color: Colors.black54),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.save,
            color: Colors.black87,
          ),
          onPressed: (){
            _saveDocument(context);
          },
        ),
      ]),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 10),
            child: TextField(
              autofocus: true,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                _title = value;
                FocusScope.of(context).requestFocus(_focusNode);
              },
            ),
          ),
          Expanded(
            child: ZefyrScaffold(
              child: ZefyrTheme(
                data: new ZefyrThemeData(
                  cursorColor: Colors.blue,
                  toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
                    color: Colors.grey.shade800,
                    toggleColor: Colors.grey.shade900,
                    iconColor: Colors.white,
                    disabledIconColor: Colors.grey.shade500,
                  ),
                ),
                child: new ZefyrEditor(
                  controller: _controller,
                  focusNode: _focusNode,
                ),
              ),

            ),
          ),
        ],
      )),
    );
  }

  NotusDocument _loadDocument() {
    final Delta delta = Delta()..insert("Note\n");
    return NotusDocument.fromDelta(delta);
  }

  void _saveDocument(BuildContext context){
    final contents = jsonEncode(_controller.document);
    Toast.show(contents, context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);



  }

  final Future<Database> database  = openDatabase(
    join(, 'my_note.db'),
  );
}



class Note {
  final int id;
  final String title;
  final String data;
  final bool favourite;
  final BigInt syncId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note(this.id, this.title, this.data, this.favourite, this.syncId,
      this.createdAt, this.updatedAt);


}
