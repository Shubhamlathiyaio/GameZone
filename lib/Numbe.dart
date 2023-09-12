import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class number extends StatefulWidget {
  const number({super.key});

  @override
  State<number> createState() => _numberState();
}

class _numberState extends State<number> {
  List<bool> b = List.filled(9, true);
  List<int> m = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  int k = 8;
  int cnt = -1;
  reset(int n) async {
    int a = 0;
    for (var i = 0; i < n;) {
      if (k != 2 && k != 5) {
        List temp = [k + 1, k - 3, k + 3];
        temp.shuffle();
        a = temp[0];
      }
      if (k != 3 && k != 6) {
        List temp = [k - 1, k - 3, k + 3];
        temp.shuffle();
        a = temp[0];
      }
      if (a >= 0 && a <= 8) {
        await Future.delayed(Duration(milliseconds: 500)).then((value) => i++);
        setState(() {});
        m[k] = m[a];
        m[a] = 8;
        k = a;
      }
    }
  }

  logic(int a) {
    if (((a != 2 && a != 5) && (k == a + 1 || k == a - 3 || k == a + 3)) ||
        ((a != 3 && a != 6) && (k == a - 1 || k == a - 3 || k == a + 3))) {
      b[k] = true;
      m[k] = m[a];
      m[a] = 8;
      k = a;
      b[k] = false;
      for (cnt = 0; cnt < 9; cnt++) if (m[cnt] != cnt) break;
    }
    cnt >= 8 ? b[8] = true : null;
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
    reset(Random().nextInt(100));
    setState(() {});
    logic(10);
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 125, 60, 250),
      ),
      body: Column(
        children: [
          Container(
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
                  replacement: Card(
                    color: Colors.transparent,
                    child: Center(
                        child: Text(
                      '',
                      style: TextStyle(fontSize: 36),
                    )),
                  ),
                  child: InkWell(
                    onTap: () => cnt >= 8 ? null : logic(index),
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment(
                                    index % 3 - 1, (index / 3).toInt() - 1),
                                end: Alignment((8 - index) % 3 - 1,
                                    ((8 - index) / 3).toInt() - 1),
                                colors: [
                              Color.fromARGB(155, 125, 60, 250),
                              (cnt > index)
                                  ? Colors.white
                                  : Color.fromARGB(155, 125, 60, 250),
                            ])),
                        child: Center(
                            child: Text(
                          '${m[index] + 1}',
                          style: TextStyle(fontSize: 36),
                        )),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => reset(Random().nextInt(100)),
              child: Text('RESET'),
            ),
          )
        ],
      ),
    );
  }
}
