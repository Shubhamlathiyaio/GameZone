import 'package:flutter/material.dart';
import 'package:gamezone/Games/Snake.dart';

import 'Games/Numbe.dart';
import 'Games/Split.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: split(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 125, 60, 250),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 1),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => snack(),
                    ));
              } else if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => split(),
                    ));
              }else
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return number();
                  },
                ));
            },
            child: Card(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        image: AssetImage('Asset/Number.png'),
                        fit: BoxFit.fill)),
                child: Container(
                  margin: EdgeInsets.only(bottom: 120, left: 5, right: 5),
                  color: Color.fromARGB(255, 160, 140, 239),
                  child: ListTile(
                    title: Text('Number puzzle',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
