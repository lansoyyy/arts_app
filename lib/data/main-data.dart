import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Artworks {
  final int? artworkId;
  final String artTitle;
  final String artDetails;
  final String addInfo;
  final String artistName;
  final String period;
  final String artistDetails;
  final String artworkImage;
  final String artistImage;
  final String labelName;

  Artworks(
      {this.artworkId, required this.artTitle, required this.artDetails, required this.addInfo, required this.artistName, required this.artworkImage, required this.artistImage, required this.period, required this.artistDetails, required this.labelName});

  factory Artworks.fromMap(Map<String, dynamic> json) =>
      Artworks(
          artworkId: json['artworkId'],
          artTitle: json['artTitle'],
          artDetails: json['artDetails'],
          addInfo: json['addInfo'],
          artistName: json['artistName'],
          period: json['period'],
          artistDetails: json['artistDetails'],
          artworkImage: json['artworkImage'],
          artistImage: json['artistImage'],
          labelName: json['labelName']
      );

  Map<String, dynamic> toMap() {
    return {
      'artworkId': artworkId,
      'artTitle': artTitle,
      'artDetails': artDetails,
      'addInfo': addInfo,
      'artistName': artistName,
      'period': period,
      'artistDetails': artistDetails,
      'artworkImage': artworkImage,
      'artistImage': artistImage,
      'labelName': labelName
    };
  }

}
class ArtworksDatabaseHelper {
  ArtworksDatabaseHelper._privateConstructor();

  static final ArtworksDatabaseHelper instance = ArtworksDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Artworks.db');
    return await openDatabase(
      path,
      version: 1,  // Update the version to handle the migration.
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Artworks(
      artworkId INTEGER PRIMARY KEY,
      artTitle TEXT,
      artDetails TEXT,
      addInfo TEXT,
      artistName TEXT,
      period TEXT,
      artistDetails TEXT,
      artworkImage TEXT,
      artistImage TEXT,
      labelName TEXT
    )
  ''');
    print("Artworks table created successfully!");
  }


  Future<void> importArtworkDataFromJson() async {
    String jsonString = await rootBundle.loadString('assets/data/main.json');
    List<dynamic> data = json.decode(jsonString);

    ArtworksDatabaseHelper databaseHelper = ArtworksDatabaseHelper.instance; // Access the instance from DatabaseHelper
    Database db = await databaseHelper.database;
    for (var item in data) {
      await db.insert(
        'Artworks',
        Artworks(
            artworkId: item['artworkId'],
            artTitle: item['artTitle'],
            artDetails: item['artDetails'],
            addInfo: item['addInfo'],
            artistName: item['artistName'],
            period: item['period'],
            artistDetails: item['artistDetails'],
            artworkImage: item['artworkImage'],
            artistImage: item['artistImage'],
            labelName: item['labelName']
        ).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
  Future<List<Artworks>> getAllArtworks() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('Artworks');
    return result.map((artworksMap) => Artworks.fromMap(artworksMap)).toList();
  }

  Future<Artworks> getArtworkById(String artworkId) async {
    Database db = await database; // Assuming you have a reference to the database
    List<Map<String, dynamic>> results = await db.query('Artworks', where: 'artworkId = ?', whereArgs: [artworkId]);
    if (results.isNotEmpty) {
      return Artworks.fromMap(results.first);
    } else {
      throw Exception('Artwork not found');
    }
  }
  Future<List<Artworks>> getArtworksByRecognitionLabel(String recognitionLabel) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query('Artworks', where: 'labelName = ?', whereArgs: [recognitionLabel]);
    return results.map((artworksMap) => Artworks.fromMap(artworksMap)).toList();
  }

}


String gist(Artworks artworks) => artworks.addInfo;

String description(Artworks artworks) => artworks.artDetails;

String artistdetails(Artworks artworks) => artworks.artistDetails;

String getArtworksFilename(Artworks artworks) => '${artworks.artworkImage}';

String getArtworkbyId(Artworks artworks) => '${artworks.artworkId}';