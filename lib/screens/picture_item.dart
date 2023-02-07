import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class PictureItem extends StatelessWidget {
  final String imageUrl;

  PictureItem({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Positioned(
            left: 20,
            top: 35,
            child: Hero(
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
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () async {
                var response = await http.get(
                  Uri.parse(imageUrl),
                );
                print(response);
                final Directory temp = await getTemporaryDirectory();
                final File imageFile = File('${temp.path}/tempImage.png');
                imageFile.writeAsBytesSync(response.bodyBytes);
                Share.shareXFiles([XFile('${temp.path}/tempImage.png')]);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
                height: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Center(
                    child: Text(
                  "Paylaş",
                  style: TextStyle(fontSize: 22, color: Colors.black),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
