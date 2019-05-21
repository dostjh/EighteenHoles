import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Hole {
  final int id;
  int par;
  int strokes;

  Hole(this.id, this.par, this.strokes);
}

List<Hole> globalHoles = List.generate(18, (i) => Hole(
  i + 1,
  4,
  0
  )
);

void main() => runApp(new EighteenHolesApp());

class EighteenHolesApp extends StatefulWidget {
  @override
  _EighteenHolesAppState createState() => new _EighteenHolesAppState();
}

class _EighteenHolesAppState extends State<EighteenHolesApp> {

  HolesScreen holesScreen;
  
	@override
	Widget build(BuildContext context) {
		return new MaterialApp(
			title: 'Eighteen Holes',
			theme: new ThemeData(
				primarySwatch: Colors.lightGreen,
			),
			home: HolesScreen(),

		);
	}
}

class HolesScreen extends StatelessWidget {

  HolesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eighteen Holes'),
      ),
      body: ListView.builder(
				itemCount: globalHoles.length,
				itemBuilder: (context, index) {
					return ListTile(
						title: Text('Hole ${globalHoles[index].id}'),
						// When a user taps on the ListTile, navigate to the DetailScreen.
						// Notice that we're not only creating a DetailScreen, we're
						// also passing the current hole through to it!
						trailing: StrokesParTrailer(index),
            onTap: () {
							Navigator.push(
								context,
								MaterialPageRoute(
									builder: (context) => DetailScreen(index: index),
								),
							);
						}
					);
				},
			),
		);
	}
}

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the hole
  final int index;

  DetailScreen({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Hole to create our UI
    return Scaffold(
      appBar: AppBar(
        title: Text('Hole ${globalHoles[index].id}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            NumberIncrementDecrementRow(index),
          ]
        )
      ),
    );
  }
}

class StrokesParTrailer extends StatefulWidget{
  final int index;

  StrokesParTrailer(this.index);

  @override
  _StrokesParTrailerState createState() => _StrokesParTrailerState(index);
}

class _StrokesParTrailerState extends State<StrokesParTrailer> {
  final int index;
  int strokes;
  int par;

  _StrokesParTrailerState(this.index) {
    strokes = globalHoles[index].strokes;
    par = globalHoles[index].par;
  }

  @override
  Widget build(BuildContext context) {
    return new Text('${globalHoles[index].strokes} / ${globalHoles[index].par}');
  }
}

class NumberIncrementDecrementRow extends StatefulWidget {
  final int index;

  NumberIncrementDecrementRow(this.index);
  
  @override
  _NumberIncrementDecrementRowState createState() => _NumberIncrementDecrementRowState(index);
}

class _NumberIncrementDecrementRowState extends State<NumberIncrementDecrementRow> {
  final int index;
  int strokes;
  int par;

  void decrementStrokes() {
    if (strokes > 1) {
      setState(() {
        this.strokes--;
      });
      globalHoles[index].strokes--;
    }
  }

  void incrementStrokes() {
    setState(() {
      this.strokes++;
    });
    globalHoles[index].strokes++;
  }

  void decrementPar() {
    if (par > 1) {
      setState(() {
        this.par--;
      });
      globalHoles[index].par--;
    }
  }

  void incrementPar() {
    setState(() {
      this.par++;
    });
    globalHoles[index].par++;
  }

  _NumberIncrementDecrementRowState(this.index){
    strokes = globalHoles[index].strokes;
    par = globalHoles[index].par;
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Text('Strokes'),
            new RaisedButton(
              onPressed: decrementStrokes,
              child: Text('-'),
            ),
            new Text('$strokes'),
            new RaisedButton(
              onPressed: incrementStrokes,
              child: Text('+'),
            ),
          ],
        ),
        new Row(
          children: <Widget>[
            new Text('Par'),
            new RaisedButton(
              onPressed: decrementPar,
              child: Text('-'),
            ),
            new Text('$par'),
            new RaisedButton(
              onPressed: incrementPar,
              child: Text('+'),
            ),
          ],
        ),
      ]
    );
  }
}