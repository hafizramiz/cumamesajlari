import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingListPage extends StatefulWidget {
  const LoadingListPage({super.key});

  @override
  State<LoadingListPage> createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child:SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Expanded(child: BannerPlaceholder()),
                        Expanded(child: BannerPlaceholder())
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: BannerPlaceholder()),
                        Expanded(child: BannerPlaceholder())
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: BannerPlaceholder()),
                        Expanded(child: BannerPlaceholder())
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: BannerPlaceholder()),
                        Expanded(child: BannerPlaceholder())
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: BannerPlaceholder()),
                        Expanded(child: BannerPlaceholder())
                      ],
                    ),
                  ],
                ),
            ),
            ),
          )
    );
  }
}


class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class BannerPlaceholder2 extends StatelessWidget {
  const BannerPlaceholder2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

