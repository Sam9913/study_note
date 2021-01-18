import 'package:flutter/material.dart';
import 'package:study_note/wordOfDay.dart';
import './newWord.dart';
import './noteList.dart';
import './myModel.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
        create: (ctx) => MyModel(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            accentColor: Colors.white,
            primaryColor: Color.fromRGBO(162, 136, 166, 1.0),
            buttonTheme: ButtonThemeData(
              buttonColor: Color.fromRGBO(162, 136, 166, 1.0),
              textTheme: ButtonTextTheme.accent,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color.fromRGBO(162, 136, 166, 1.0),
              foregroundColor: Color.fromRGBO(241, 227, 228, 1.0),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Dictionary(),
        ));
  }
}

class Dictionary extends StatefulWidget {
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromRGBO(187, 155, 176, 1.0),
                      foregroundColor: Color.fromRGBO(241, 227, 228, 1.0),
                      radius: 45,
                      child: Text('SH'),
                    ),
                    Text(
                      'Sze Hsien',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(162, 136, 166, 1.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('History'),
              ),
              ListTile(
                leading: Icon(Icons.new_releases),
                title: Text('Word of the Day'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return WordOfDay(launchURL);
                  }));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Dictionary List'),
          bottom: TabBar(
            labelPadding: EdgeInsets.all(8.0),
            tabs: [
              Text('Japanese'),
              Text('Korean'),
              Text('English'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NoteList(launchURL, 'Japanese'),
            NoteList(launchURL, 'Korean'),
            NoteList(launchURL, 'English'),
          ],
        ),
        floatingActionButton: Consumer<MyModel>(builder: (ctx, myModel, child) {
          return FloatingActionButton(
            onPressed: () => showModal(ctx, myModel),
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }

  showModal(BuildContext ctx, MyModel myModel) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(
            onTap: () {},
            child: Wrap(
              children: [NewWord(myModel.addNewWord, myModel.wordController)],
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  launchURL(note) async {
    var url = (note.languageCode == 'Japanese'
            ? 'https://jisho.org/search/'
            : note.languageCode == 'English'
                ? 'https://dictionary.cambridge.org/dictionary/english/'
                : 'https://papago.naver.com/?sk=ko&tk=zh-CN&st=') +
        note.word;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
