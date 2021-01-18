import 'package:flutter/material.dart';
import 'package:study_note/myModel.dart';
import './model.dart';
import 'package:provider/provider.dart';

class NoteList extends StatefulWidget {
  final Function _launchURL;
  final String _language;

  NoteList(this._launchURL, this._language);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    List<Note> _dictionaryList =
        Provider.of<MyModel>(context, listen: false).dictionaryList;

    return Consumer<MyModel>(
      builder: (context, myModel, child) => Container(
          child: _dictionaryList.where((word) {
                    return word.languageCode == widget._language;
                  }).length ==
                  0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/undraw_blank_canvas_3rbb.png"),
                    Text("You don't have any ${widget._language} note yet!")
                  ],
                )
              : Column(
                  children: [
                    ..._dictionaryList.where((note) {
                      return note.languageCode == widget._language;
                    }).map((note) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Dismissible(
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                onDismissed: (DismissDirection direction) {
                                  setState(() {
                                    _dictionaryList.removeWhere((note2) {
                                      return note2.word == note.word;
                                    });
                                  });
                                },
                                key: Key(note.word),
                                child: ListTile(
                                  onTap: () {
                                    widget._launchURL(note);
                                  },
                                  title: Text(note.word),
                                  trailing: Icon(Icons.navigate_next),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                            ]),
                      );
                    }).toList(),
                  ],
                )),
    );
  }
}
