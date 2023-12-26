import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class PictureItem extends StatelessWidget {
  final String imageUrl;

  PictureItem({required this.imageUrl, Key? key}) : super(key: key);
  var random = Random();
  late String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
        tag: imageUrl,
        child: Material(
          color: Colors.transparent,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
        ),
      ),

      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            InkWell(
              onTap: () async {
                var response = await http.get(
                  Uri.parse(imageUrl),
                );
                final Directory temp = await getTemporaryDirectory();
                final File imageFile = File('${temp.path}/Image.png');
                imageFile.writeAsBytesSync(response.bodyBytes);
                Share.shareXFiles([XFile('${temp.path}/Image.png')]);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share),
                      SizedBox(width: 30,),
                      Center(
                          child: Text(
                        "Paylaş",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      )),
                    ],
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: () async {
                var response = await http.get(
                  Uri.parse(imageUrl),
                );

                try {
                  final dir = await getTemporaryDirectory();
                  var filename = '${dir.path}/SaveImage${random.nextInt(100)}.png';
                  final file = File(filename);
                  await file.writeAsBytes(response.bodyBytes);
                  final params = SaveFileDialogParams(sourceFilePath: file.path);
                  final finalPath = await FlutterFileDialog.saveFile(params: params);

                  if (finalPath != null) {
                    message = 'Resim başarıyla kaydedildi';
                  }
                } catch (e) {
                  message = e.toString();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      message,
                      style:  TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.grey,
                  ));
                }
                if (message != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      message,
                      style:  TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.grey,
                  ));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.file_download, color: Colors.white),
                      SizedBox(width: 30),
                      Text(
                        "İndir",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
