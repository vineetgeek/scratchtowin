import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //import images
  AssetImage circle = AssetImage('images/circle.png');
  AssetImage lucky = AssetImage('images/rupee.png');
  AssetImage unlucky = AssetImage('images/sadFace.png');

  //get an array

  late List<String> itemArray;
  late int luckyNumber;

  // init array  with 25 array

  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(35, (index) => "empty");
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(35);
    setState(() {
      luckyNumber = random;
    });
  }

  //define getimage method

  AssetImage getImage(int index) {
    String currentImage = itemArray[index];
    switch (currentImage) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
      default:
    }
    return circle;
  }

  //play game method

  playGame(int index) {
    if (luckyNumber == index) {
      setState(() {
        itemArray[index] = "lucky";
      });
    } else {
      setState(() {
        itemArray[index] = "unlucky";
      });
    }
  }

  //show all

  showAll() {
    setState(() {
      itemArray = List<String>.filled(35, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

  //reset all
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(35, "empty");
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch and Win"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0),
              itemCount: itemArray.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    this.playGame(i);
                  },
                  child: Image(
                    image: this.getImage(i),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                this.showAll();
              },
              color: Colors.red,
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Show All",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                this.resetGame();
              },
              color: Colors.red,
              padding: EdgeInsets.all(20.0),
              child: Text(
                "ResetGame All",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
