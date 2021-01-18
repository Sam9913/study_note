import 'package:flutter/material.dart';
import './myModel.dart';
import 'package:provider/provider.dart';

class NewWord extends StatelessWidget {
  final Function _addNewWord;
  final TextEditingController _wordController;
  static const List<String> language = ['Japanese', 'Korean', 'English'];

  NewWord(this._addNewWord, this._wordController);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            cursorColor: Color.fromRGBO(187, 155, 176, 1.0),
            decoration: InputDecoration(labelText: 'Word'),
            controller: _wordController,
          ),
          Consumer<MyModel>(
            builder: (context, myModel, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Language'),
                    ...language.map((lang) {
                      return ListTile(
                        title: Text(lang),
                        leading: Radio(
                          value: lang,
                          groupValue: myModel.lang,
                          activeColor: Colors.purpleAccent[100],
                          onChanged: (value) {
                            myModel.changeLanguage(value);
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            },
            /* return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Language'),
                ...language.map((lang) {
                  return ListTile(
                    title: Text(lang),
                    leading: Radio(
                      value: lang,
                      groupValue: _lang,
                      activeColor: Colors.purpleAccent[100],
                      onChanged: (value) {},
                    ),
                  );
                }).toList(),
              ],
            ),
          ); */
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Color.fromRGBO(28, 29, 33, 1.0)),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _addNewWord(_wordController.text);
                },
                child: Text("Save"),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
