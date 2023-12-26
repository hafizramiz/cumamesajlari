import 'package:cumamesajlari/screens/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // return ExampleUiLoadingAnimation();
    //return Center(child: CircularProgressIndicator(),);
     return LoadingListPage();
  }
}

