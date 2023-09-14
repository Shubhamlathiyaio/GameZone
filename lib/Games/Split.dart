import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class split extends StatefulWidget {
  const split({super.key});

  @override
  State<split> createState() => _splitState();
}

class _splitState extends State<split> {
  List<img.Image> parts = [];
  List<img.Image> pos = [];
  int col=3;
  int row=3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageFileFromAssets('Asset/i.jpg').then(
      (value) {
        var image = img.decodeJpg(value.readAsBytesSync());
        parts = splitImage(image!, row, col);
        pos = parts;
        parts.shuffle();
      },
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  List<img.Image> splitImage(
      img.Image inputImage, int horizontalPieceCount, int verticalPieceCount) {
    img.Image image = inputImage;

    final pieceWidth = (image.width / horizontalPieceCount).round();
    final pieceHeight = (image.height / verticalPieceCount).round();
    final pieceList = List<img.Image>.empty(growable: true);

    for (var y = 0; y < image.height; y += pieceHeight) {
      for (var x = 0; x < image.width; x += pieceWidth) {
        pieceList.add(img.copyCrop(image,
            x: x, y: y, width: pieceWidth, height: pieceHeight));
      }
    }

    return pieceList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Make the image'),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: col, crossAxisSpacing: 2, mainAxisSpacing: 2),
          itemCount: parts.length,
          itemBuilder: (context, index) => con(index),
        ));
  }
bool drag=false;
  Widget con(int a) {
    double h = MediaQuery.of(context).size.height;
    h = (h - (row-1)*2) / row;
    double w = MediaQuery.of(context).size.width;
    w = (w - (col-1)*2) / col;
    var q;
    return drag  ? DragTarget(onAccept: (data) => setState(() {
      q=parts[a];
      parts[a]=parts[data as int];
      parts[data]=q;
    }),builder: (context, candidateData, rejectedData) {
      return Image.memory(img.encodeJpg(parts[a]),);
    },) : Draggable(data: a,
        onDraggableCanceled: (velocity, offset) => setState(() {
      drag=false;
    }),onDragCompleted: () => setState(() {
      drag=false;
      win();
    }),onDragStarted: () => setState(() {
      drag=true;
    }),
        feedback: Container(
            height: h,
            width: w,
            child: Image.memory(
              img.encodeJpg(parts[a]),
              opacity: AlwaysStoppedAnimation(.8),
            )),
        child:
        Image.memory(img.encodeJpg(parts[a])));
  }
  win()
  {
    int cnt=0;
    for(int i=0,cnt=0;i<pos.length;i++) if(parts[i]==pos[i]) cnt++;
    if(pos.length==cnt)
    {
      showDialog(context: context, builder: (context) {
        return AlertDialog(title: Text('Win',style: TextStyle(fontSize: 32)),content: Text('✨🎊🧩🧩🧩🧩!!..You win the level...!!😁'),);
      },);
    }
  }
}
