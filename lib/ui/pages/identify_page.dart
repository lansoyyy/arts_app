import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class IdentifyPage extends StatefulWidget {
  const IdentifyPage({Key? key}) : super(key: key);

  @override
  State<IdentifyPage> createState() => _IdentifyPageState();
}

class _IdentifyPageState extends State<IdentifyPage> {
  late String output = '';

  late File pickedImage;

  bool isImageLoaded = false;

  late List result;

  late String accuracy = '';

  late String name = '';

  late String numbers = '';

  getImageCamera(String imgsrc) async {
    setState(() {
      hasLoaded = false;
    });
    var tempStore = await ImagePicker().pickImage(
        source: imgsrc == 'camera' ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      pickedImage = File(tempStore!.path);
      isImageLoaded = true;
      applyModel(File(tempStore.path));
      hasLoaded = true;
    });
  }

  List works = [];

  loadmodel() async {
    try {
      await Tflite.loadModel(
        model: "assets/CNN/model.tflite",
        labels: "assets/CNN/labels.txt",
      );
    } catch (e) {
      print('error $e');
    }

    works = jsonDecode(await rootBundle.loadString('assets/data/main.json'));

    setState(() {
      hasLoaded = true;
    });
  }

  String str = '';

  applyModel(File file) async {
    var res = await Tflite.runModelOnImage(
        path: file.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true);
    setState(() {
      print('res $res');
      result = res!;
      print('result:$result');
      str = '${result[0]['label']}';
    });

    print(str);

    for (int i = 0; i < works.length; i++) {
      if (works[i]['labelName'] == str) {
        showModalBottomSheet(
          enableDrag: true,
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return SizedBox(
              height: 650,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              getImageCamera('camera');
                            },
                            icon: const Icon(Icons.close)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(works[i]['artworkImage']),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          works[i]['artTitle'],
                          style: GoogleFonts.openSansCondensed(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
                        child: Text(
                          works[i]['addInfo'],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Description',
                          style: GoogleFonts.openSansCondensed(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
                        child: Text(
                          works[i]['artDetails'] ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'About the Artist',
                          style: GoogleFonts.openSansCondensed(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
                        child: Text(
                          works[i]['artistName'] ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
                        child: Text(
                          works[i]['period'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ]),
              ),
            );
          },
        );
      }
    }
  }

  bool hasLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadmodel();
    getImageCamera('camera');
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
