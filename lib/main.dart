import 'package:flutter/material.dart';
import 'package:my_note/models/model.dart';
import 'package:toast/toast.dart';
import 'pages/create_note.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my Note',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'my Note'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var notesList;

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }


  Future<void> _getData() async {
    var data = await Note().select().toList();
    print("Counter........");
    print(data.length);
    setState((){
      notesList = data;
    });
    print(data.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Notes",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.grey,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                FutureBuilder<List>(
                  future: Note().select().toList(),
                  initialData: List(),
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                          itemBuilder: (_, int position){
                            final item = snapshot.data[position];
                            return Card(
                              child: ListTile(
                                title: Text(item.title),
                              ),
                            );
                          }
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewNote()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildRow(Note note){
    return ListTile(
      title: Text(
        note.title
      ),
      trailing: Icon(
        note.favourite ? Icons.favorite : Icons.favorite_border,
        color: note.favourite ? Colors.red : null,
      ),
      onTap: () {

      },
    );
  }

}
