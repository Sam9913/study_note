import 'package:flutter/material.dart';
import 'package:study_note/model.dart';
import 'package:study_note/myModel.dart';
import 'package:provider/provider.dart';
import 'myModel.dart';

class WordOfDay extends StatefulWidget {
  final Function _launchURL;

  WordOfDay(this._launchURL);

  @override
  _WordOfDayState createState() => _WordOfDayState();
}

class _WordOfDayState extends State<WordOfDay> {
  final List<DailyWord> _dailyWordList = [
    DailyWord(
      languageCode: 'English',
      word: 'English',
      isAdded: false,
    ),
    DailyWord(
      languageCode: 'Japanese',
      word: '日本',
      isAdded: false,
    ),
    DailyWord(
      languageCode: 'Korean',
      word: '한국',
      isAdded: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word of the Day'),
      ),
      body: Container(
        child: Column(
          children: [
            ..._dailyWordList.map((note) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<MyModel>(
                        builder: (context, myModel, child) => ListTile(
                          onTap: () {
                            widget._launchURL(note);
                          },
                          title: Text(note.word),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (!note.isAdded) {
                                      setState(() {
                                        note.isAdded = true;
                                      });
                                      myModel.addToDict(note).then((value) {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text('Added to dictionary list.'),
                                          action: SnackBarAction(
                                            label: 'Cancel',
                                            onPressed: () {
                                              setState(() {
                                                note.isAdded = false;
                                              });
                                              myModel.deleteFromDict(note);
                                            },
                                          ),
                                        ));
                                      });
                                    }
                                  },
                                  child: Icon(Icons.add_circle_rounded)),
                              Icon(Icons.navigate_next)
                            ],
                          ),
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
        ),
      ),
    );
  }
}
