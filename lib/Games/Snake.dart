import 'dart:math';

import 'package:flutter/material.dart';

class snack extends StatefulWidget {
  const snack({super.key});

  @override
  State<snack> createState() => _snackState();
}

class _snackState extends State<snack> {
  @override
  void initState() {
    fun();
  }

  fun() {
    for (int i = 0; i < body.length - 1; i++) body[i] = body[i + 1];
    body[body.length - 1] = head;
    if (d == 0) head = head - col <= -1 ? head - col + n : head - col;
    if (d == 1) head = head % col == 0 ? head + col : head - 1;
    if (d == 2) head = ((head + 1) % col == 0) ? head - col - 1 : head + 1;
    if (d == 3) head = head + col >= n ? head + col - n : head + col;
    print(head);
    if (head == y) {
      body.add(body[body.length - 1]);
      for (int i = body.length - 2; i > 0; i--) body[i + 1] = body[i];
      body[0] = head;
      food = true;
    }
    while (food) {
      y = Random().nextInt(n);
      if (!body.contains(y) && y != head && y != n) food = false;
    }
    setState(() {});
    Future.delayed(Duration(milliseconds: speed)).then((value) => fun());
  }

  int d = 2;
  bool food = true;
  int y = 0;
  int speed = 200;
  int col = 20;
  int head = 5;
  int n = 600;
  List<int> body = [0, 1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              color: Colors.black,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: col),
                itemCount: n,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      color: index == head
                          ? Colors.red
                          : body.contains(index)
                              ? Colors.blue
                              : y == index
                                  ? Colors.yellow
                                  : Colors.black,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.brown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btn(0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      btn(1),
                      Container(
                        height: 99,
                        width: 150,
                      ),
                      btn(2),
                    ],
                  ),
                  btn(3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List arrow = [
    Icon(Icons.arrow_upward),
    Icon(Icons.arrow_left),
    Icon(Icons.arrow_right),
    Icon(Icons.arrow_downward),
  ];
  Widget btn(int a) {
    return InkWell(
      onTap: () {
        d = d == 0
            ? a == 3
                ? d
                : a
            : d == 1
                ? a == 2
                    ? d
                    : a
                : d == 2
                    ? a == 1
                        ? d
                        : a
                    : d == 3
                        ? a == 0
                            ? d
                            : a
                        : d;
        setState(() {});
      },
      child: Container(
        height: 60,
        width: 60,
        child: arrow[a],
      ),
    );
  }
}
