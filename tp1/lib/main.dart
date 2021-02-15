import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'My music';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  String _message = "";
  static List<String> _musics = <String>[];
  static List<String> _saved = <String>[];
  static List<String> _playlists = <String>[];
  static List<String> _imagesLinks = <String>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions;

  _MyStatefulWidgetState() {
    _musics = [
      "Candy From Strangers",
      "Red Armor",
      "Simple Motion",
      "Intergalactic Emotional Breakdown",
      "Something True"
    ];
    _saved = [];
    _playlists = ["Rock", "Techno", "Jazz"];
    _imagesLinks = ["images/rock.jpg", "images/techno.jpg", "images/jazz.jpg"];
    _widgetOptions = <Widget>[
      _buildMusics(),
      _buildPlaylists(),
      _buildSaved(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage your music !'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: _pushAdd),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.audiotrack),
            label: 'Playlists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Liked',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _pushAdd() {
    _message = "";
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Text('What do you want to add ?'),
              ),
              body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _message,
                        style: TextStyle(fontSize: 20, color: Colors.orange),
                        textAlign: TextAlign.center,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "New Song", hintText: "Enter the title"),
                        keyboardType: TextInputType.text,
                        onSubmitted: submit,
                      )
                    ]),
              ));
        },
      ),
    );
  }

  void submit(String music) {
    setState(() {
      _musics.add(music);
      _message = "Song added !";
    });
  }

  Widget _buildMusics() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        // The itemBuilder callback is called once per suggested
        // word pairing, and places each suggestion into a ListTile
        // row. For even rows, the function adds a ListTile row for
        // the word pairing. For odd rows, the function adds a
        // Divider widget to visually separate the entries. Note that
        // the divider may be difficult to see on smaller devices.
        // ignore: missing_return
        itemBuilder: (BuildContext _context, int i) {
          if ((_musics.length > 0) & (i < _musics.length)) {
            return _buildMusicRow(_musics[i]);
          }
        });
  }

  Widget _buildMusicRow(String music) {
    final alreadySaved = _saved.contains(music);
    return ListTile(
      title: Text(
        music,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(music);
          } else {
            _saved.add(music);
          }
        });
      },
    );
  }

  Widget _buildSaved() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        // The itemBuilder callback is called once per suggested
        // word pairing, and places each suggestion into a ListTile
        // row. For even rows, the function adds a ListTile row for
        // the word pairing. For odd rows, the function adds a
        // Divider widget to visually separate the entries. Note that
        // the divider may be difficult to see on smaller devices.
        // ignore: missing_return
        itemBuilder: (BuildContext _context, int i) {
          if ((_saved.length > 0) & (i < _saved.length)) {
            return _buildMusicRow(_saved[i]);
          }
        });
  }

  Widget _buildPlaylists() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        // The itemBuilder callback is called once per suggested
        // word pairing, and places each suggestion into a ListTile
        // row. For even rows, the function adds a ListTile row for
        // the word pairing. For odd rows, the function adds a
        // Divider widget to visually separate the entries. Note that
        // the divider may be difficult to see on smaller devices.
        // ignore: missing_return
        itemBuilder: (BuildContext _context, int i) {
          if ((_playlists.length > 0) & (i < _playlists.length)) {
            return _buildPlaylistRow(_playlists[i], _imagesLinks[i]);
          }
        });
  }

  Widget _buildPlaylistRow(String playlist, String link) {
    return ListTile(
      title: Text(
        playlist,
        style: _biggerFont,
      ),
      trailing: Image(image: AssetImage(link)),
    );
  }
}
