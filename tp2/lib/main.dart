import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Todo {
  final String title;
  final String description;
  final Widget content;

  Todo(this.title, this.description, this.content);
}

void main() {
  var titres = [
    "Exercice 1",
    "Exercice 2",
    "Exercice 4",
    "Exercice 5",
    "Exercice 6a",
    "Exercice 6b"
  ];
  var descriptions = [
    "Afficher une image",
    "Effectuer plusieurs transformations sur une image",
    "Affichage d'un morceau de l'image (tuile)",
    "Transformation de l'image en grille de tuiles",
    "Inversement de 2 tiles",
    "Déplacement de tiles dans une grille"
  ];
  var exercices = [
    Exercice1(),
    Exercice2(),
    Exercice4(),
    Exercice5(),
    Exercice6a(),
    Exercice6b()
  ];
  runApp(MaterialApp(
    title: 'TP2',
    home: TodosScreen(
      todos: List.generate(
        6,
        (i) => Todo(titres[i], descriptions[i], exercices[i]),
      ),
    ),
  ));
}

class TodosScreen extends StatelessWidget {
  final List<Todo> todos;

  TodosScreen({Key key, @required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TP2'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            subtitle: Text(todos[index].description),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => todos[index].content,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Exercice1 extends StatelessWidget {
  Exercice1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercice 1"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network('https://picsum.photos/512/1024',
              width: 512, height: 1024)
        ],
      ),
    );
  }
}

class Exercice2 extends StatefulWidget {
  @override
  _Exercice2 createState() => _Exercice2();
}

class _Exercice2 extends State<Exercice2> {
  double rotationXvalue = 0;
  double rotationZvalue = 0;
  double scaleValue = 1;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercice 2"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(color: Colors.white),
              child: Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.rotationX(rotationXvalue * 6.28),
                  child: Transform.rotate(
                      angle: rotationZvalue * 6.28,
                      child: Transform.scale(
                        scale: scaleValue,
                        child: Image.network('https://picsum.photos/512/1024',
                            width: 512, height: 1024),
                      )))),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text("Rotate X :"),
            Slider(
              value: rotationXvalue,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double value) {
                setState(() {
                  rotationXvalue = value;
                });
              },
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text("Rotate Z :"),
            Slider(
              value: rotationZvalue,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double value) {
                setState(() {
                  rotationZvalue = value;
                });
              },
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text("Scale :"),
            Slider(
              value: scaleValue,
              min: 0,
              max: 2,
              divisions: 100,
              onChanged: (double value) {
                setState(() {
                  scaleValue = value;
                });
              },
            )
          ])
        ],
      ),
    );
  }
}

class Exercice4 extends StatelessWidget {
  Tile tile = new Tile(
      imageURL: 'https://picsum.photos/512', alignment: Alignment(0, 0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Affichage d'une tuile"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(children: [
        SizedBox(
            width: 150.0,
            height: 150.0,
            child: Container(
                margin: EdgeInsets.all(20.0),
                child: this.createTileWidgetFrom(tile))),
        Container(
            height: 200,
            child:
                Image.network('https://picsum.photos/512', fit: BoxFit.cover))
      ])),
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({this.imageURL, this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }

  Widget croppedImageTile2(int index, int taille) {
    int q = index ~/ taille;
    int r = index % taille;
    int n = taille - 1;

    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: FractionalOffset(r / n, q / n),
            widthFactor: 1 / taille,
            heightFactor: 1 / taille,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

class Exercice5 extends StatefulWidget {
  @override
  _Exercice5 createState() => _Exercice5();
}

class _Exercice5 extends State<Exercice5> {
  Tile tile = new Tile(
      imageURL: 'https://picsum.photos/512', alignment: Alignment(0, 0));
  double size = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercice 5'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 600,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size.toInt(),
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4),
                itemCount: math.pow(size.toInt(), 2),
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                      SizedBox(
                        width: (500 - (size - 1) * 4) / size,
                        height: (500 - (size - 1) * 4) / size,
                        child: Container(
                          margin: EdgeInsets.all(0.0),
                          child: this
                              .createTileWidgetFrom2(tile, index, size.toInt()),
                        ),
                      ),
                    ]),
                  );
                }),
          ),
          Slider(
            min: 3.0,
            max: 9.0,
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
            divisions: 6,
            value: size,
            label: size.round().toString(),
            onChanged: (double newsize) {
              setState(() {
                size = newsize;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget createTileWidgetFrom2(Tile tile, int index, int taille) {
    return InkWell(
      child: tile.croppedImageTile2(index, taille),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}

math.Random random = new math.Random();

class Tile2 {
  Color color;

  Tile2(this.color);
  Tile2.randomColor() {
    this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}

class TileWidget extends StatelessWidget {
  final Tile2 tile;

  TileWidget(this.tile);

  @override
  Widget build(BuildContext context) {
    return this.coloredBox();
  }

  Widget coloredBox() {
    return Container(
        color: tile.color,
        child: Padding(
          padding: EdgeInsets.all(70.0),
        ));
  }
}

class Exercice6a extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Exercice6a();
}

class _Exercice6a extends State<Exercice6a> {
  List<Widget> tiles =
      List<Widget>.generate(2, (index) => TileWidget(Tile2.randomColor()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercice 6a"),
        centerTitle: true,
      ),
      body: Row(children: tiles),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.sentiment_very_satisfied), onPressed: swapTiles),
    );
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}

class Exercice6b extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Exercice6b();
}

class _Exercice6b extends State<Exercice6b> {
  double size = 3;
  List<NewTile> tiles;
  int indexEmpty = 6;
  @override
  void initState() {
    super.initState();
    tiles = initTiles();
  }

  List<NewTile> initTiles() {
    return (List.generate(
        size.toInt() * size.toInt(),
        (index) =>
            new NewTile(imageURL: 'https://picsum.photos/512', index: index)));
  }

  List<Widget> getTileWidgets(List<NewTile> inittiles) {
    List<Widget> tiles = [];
    EmptySpace emptySpace = EmptySpace(index: indexEmpty);
    for (var i = 0; i < math.pow(size.toInt(), 2); i++) {
      if (i == indexEmpty) {
        tiles.add(emptySpace.newCroppedImageTile(size.toInt()));
      } else {
        tiles.add(newCreateTileWidgetFrom(inittiles[i], i, size.toInt()));
      }
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercice 6b"),
      ),
      body: ListView(
        children: [
          Flexible(
            child: SizedBox(
                height: 600,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(0),
                  crossAxisCount: size.toInt(),
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  children: getTileWidgets(tiles),
                )),
          ),
          Slider(
            min: 3.0,
            max: 9.0,
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
            divisions: 6,
            value: size,
            label: size.round().toString(),
            onChanged: (double newsize) {
              setState(() {
                size = newsize;
                tiles = initTiles();
                indexEmpty = newsize.toInt() * (newsize.toInt() - 1);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget newCreateTileWidgetFrom(
    NewTile plateau,
    int index,
    int taille,
  ) {
    Widget tuile;
    tuile = plateau.newCroppedImageTile(taille);
    return InkWell(
      child: tuile,
      onTap: () {
        swapTile(index);
      },
    );
  }

  swapTile(int index) {
    print("${index}");
    if (indexEmpty == index + size.toInt()) {
      setState(() {
        tiles.insert(index, tiles.removeAt(indexEmpty));
        tiles.insert(indexEmpty, tiles.removeAt(index + 1));
        indexEmpty = index;
      });
    }
    if (indexEmpty == index - size.toInt()) {
      setState(() {
        tiles.insert(indexEmpty, tiles.removeAt(index));
        tiles.insert(index, tiles.removeAt(indexEmpty + 1));
        indexEmpty = index;
      });
    }
    if ((indexEmpty == index - 1) &&
        (indexEmpty % size.toInt() != size.toInt() - 1)) {
      setState(() {
        tiles.insert(indexEmpty, tiles.removeAt(index));
        indexEmpty = index;
      });
    }
    if ((indexEmpty == index + 1) && (indexEmpty % size.toInt() != 0)) {
      setState(() {
        tiles.insert(index, tiles.removeAt(indexEmpty));
        indexEmpty = index;
      });
    }
  }
}

class NewTile {
  String imageURL;
  int index;

  NewTile({this.imageURL, this.index});

  Widget newCroppedImageTile(int taille) {
    int q = index ~/ taille;
    int r = index % taille;
    int n = taille - 1;

    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: FractionalOffset(r / n, q / n),
            widthFactor: 1 / taille,
            heightFactor: 1 / taille,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

class EmptySpace {
  int index;

  EmptySpace({this.index});

  Widget newCroppedImageTile(int taille) {
    int q = index ~/ taille;
    int r = index % taille;
    int n = taille - 1;

    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: FractionalOffset(r / n, q / n),
            widthFactor: 1 / taille,
            heightFactor: 1 / taille,
            child: Image.asset("images/Blanc.jpg"),
          ),
        ),
      ),
    );
  }
}

class Exercice7 extends StatelessWidget {
  Exercice7({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercice 4"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("Déroulé de l'exercice 4"),
      ),
    );
  }
}
