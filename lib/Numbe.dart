import 'dart:math';

import 'package:flutter/material.dart';

class number extends StatefulWidget {
  const number({super.key});

  @override
  State<number> createState() => _numberState();
}

class _numberState extends State<number> {
  List<bool> b = List.filled(9, true);
  List m = [];
  int k = 0;
  logic(int a) {
    b = List.filled(9, true);
    if (((a != 2 && a != 5) && (k == a + 1 || k == a - 3 || k == a + 3)) ||
        ((a != 3 && a != 6) && (k == a - 1 || k == a - 3 || k == a + 3))) {
      m[k] = m[a];
      k = a;
      b[k] = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    for (var i = 0; i < 9;) {
      int r = Random().nextInt(9);
      if (!m.contains(r)) {
        m.add(r);
        k = r == 8 ? i : k;
        i++;
      }
    }
    b[k] = false;
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 125, 60, 250),
      ),
      body: Container(
        height: x - 10,
        width: x,
        decoration: BoxDecoration(
            color: Color.fromARGB(50, 125, 60, 250),
            border: Border.all(width: 3)),
        margin: EdgeInsets.only(top: 70, right: 5, left: 5),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (context, index) {
            return Visibility(
              visible: b[index],
              child: InkWell(
                onTap: () => logic(index),
                child: Card(
                  color: Color.fromARGB(155, 125, 60, 250),
                  child: Center(
                      child: Text(
                    '${m[index]}',
                    style: TextStyle(fontSize: 36),
                  )),
                ),
              ),
              replacement: Card(
                color: Colors.transparent,
                child: Center(
                    child: Text(
                  '',
                  style: TextStyle(fontSize: 36),
                )),
              ),
            );
          },
        ),
      ),
    );
  }
}
