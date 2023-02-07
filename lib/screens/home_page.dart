import 'package:cached_network_image/cached_network_image.dart';
import 'package:cumamesajlari/bloc/picture_bloc.dart';
import 'package:cumamesajlari/common_widgets.dart';
import 'package:cumamesajlari/screens/picture_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../ad_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BannerAd _bannerAd;
  bool isLoaded = false;

  static const AdRequest request = AdRequest();

  void loadStaticBannedAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (ad) {
        print("Ad loaded: ${ad.adUnitId}");
        setState(() {
          isLoaded = true;
          print("Is Loaded Degeri: $isLoaded");
        });
      }, onAdFailedToLoad: (ad, err) {
        print('Failed to load a banner ad: ${err.message}');
        ad.dispose();
      }),
    );
    _bannerAd..load();
  }

  @override
  void initState() {
    loadStaticBannedAd();
    final myBloc = BlocProvider.of<PictureBloc>(context);
    myBloc.add(GetPictureEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PictureBloc, PictureState>(
      builder: (context, state) {
        if (state is PictureInitial) {
          return LoadingState();
        } else if (state is PictureLoadingState) {
          return LoadingState();
        } else if (state is PictureErrorState) {
          return ErrorState();
        } else if (state is PictureLoadedState) {
          final myPicture = state.picture;
          List<String> pictureUrlList = myPicture.pictureUrlList!;
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text("Cuma Mesajlari",style: TextStyle(color: Colors.black),),
              backgroundColor: Colors.white,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  if (isLoaded == true)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: _bannerAd.size.width.toDouble(),
                        height: _bannerAd.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd),
                      ),
                    ),
                  Flexible(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                childAspectRatio: 7 / 6,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1),
                        itemCount: pictureUrlList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Hero(
                            tag: pictureUrlList[index],
                            child: Material(
                              child: InkWell(
                                onTap: () {
                                  print(MediaQuery.of(context).size.height);
                                  print(_bannerAd.size.height.toDouble());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PictureItem(
                                              imageUrl: pictureUrlList[index])));
                                },
                                child: CachedNetworkImage(
                                  imageUrl: pictureUrlList[index],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
