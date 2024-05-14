import 'dart:math';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quotes/Model/quote_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController{
  RxInt counter = 0.obs;

  void increment(){
    counter++;
  }

  void decrement(){
    counter--;
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await Permission.storage.request();
  }

  Database? database;
  List<QuoteModel> quotes = [];
  Rx<QuoteModel?> todayQuote = Rx<QuoteModel?>(null);
  Rx<QuoteModel?> randomQuote = Rx<QuoteModel?>(null);

  Future<void> createDatabase() async{
    database = await openDatabase(
      "quotes.db",
      version: 1,
    onCreate: (database, version){
        print("Database Created");
        database.execute("CREATE TABLE Quotes (id INTEGER PRIMARY KEY, author TEXT, authorImage TEXT, quote TEXT)").then(
                (value){
                  print("Table Created");
                }).catchError((error) {
                  print(error);
        });
    },
    onOpen: (database) async {
      print("Database opened");
    }
  );
  // await deleteDatabase("quotes.db");
  }

  Future<void> insertToDatabase() async{
    await createDatabase();
    await database!.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Quotes(author, authorImage, quote) VALUES("Charles W. Eliot", "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/authors/1312422304i/4398096._UX200_CR0,60,200,200_.jpg", "Books are the quietest and most constant of friends; they are the most accessible and wisest of counselors, and the most patient of teachers.")');
    }).then((value) {
      print("Inserted Successfully");
    }).catchError((onError){
      print(onError);
    });
  }

  Future<void> getRandomQuote() async{
    await createDatabase();
    quotes = [];
    // database!.delete("Quotes",where: "id is 3");
    List<Map> response = await database!.rawQuery('SELECT * FROM Quotes WHERE id <> 1');
    for(var r in response){
      quotes.add(QuoteModel.fromJson(r));
    }
    Random random = Random();
    int randomIndex = random.nextInt(quotes.length);
    randomQuote.value = quotes[randomIndex];
    print("${quotes[randomIndex].id} : ${quotes[randomIndex].author} : ${quotes[randomIndex].quote}");
  }

  Future<void> getTodayQuote() async{
    await createDatabase();
    // database!.delete("Quotes",where: "id is 3");
    List<Map> response = await database!.rawQuery('SELECT * FROM Quotes WHERE id is 1');

    todayQuote.value = QuoteModel.fromJson(response.first);
    print("${todayQuote.value!.id} : ${todayQuote.value!.author} : ${todayQuote.value!.quote}");
  }


  final GlobalKey repaintKey = GlobalKey();

  Future<void> takeScreenShot() async{
    try {
      RenderRepaintBoundary boundary =
      repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Get directory and write the file
      final directory = (await getTemporaryDirectory()).path;
      File imgFile = File('$directory/2.png');
      await imgFile.writeAsBytes(pngBytes);

      print("Screenshot taken and saved to $directory/2.png");

      saveImageGallary('$directory/2.png');
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> DisplayPictureScreen(imagePath: "$directory/2.png")));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> gettt() async{
    await Permission.storage.request();
  }

  Future<void> saveImageGallary(String filePath) async {
    if (await Permission.storage.isGranted) {
      final result = await ImageGallerySaver.saveFile(filePath);
      if (result['isSuccess']) {
        print('Image saved to gallery successfully');
      } else {
        print('Failed to save image to gallery');
      }
    }else{
      print('Storage permission is denied');
    }
  }
}