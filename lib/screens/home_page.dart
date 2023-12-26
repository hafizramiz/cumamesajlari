import 'package:cached_network_image/cached_network_image.dart';
import 'package:cumamesajlari/bloc/picture_bloc.dart';
import 'package:cumamesajlari/screens/picture_item.dart';
import 'package:cumamesajlari/screens/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../ad_helper.dart';
import '../model/picture.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

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
          return LoadingScreen();
        } else if (state is PictureLoadingState) {
          return LoadingScreen();
        } else if (state is PictureErrorState) {
          return ErrorScreen();
        } else if (state is PictureLoadedState) {
          final Picture myPicture = state.picture;
          print("Loaded State Prop degeri: ${state.props}");
          Stream<List<String>>? pictureStreamUrlList =
              myPicture.pictureStreamUrlList;
          return  StreamBuilder<List<String?>>(
              stream: pictureStreamUrlList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<String?>> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                } else {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingScreen();
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Center(
                      child: Text("There is no internet connection"),
                    );
                  } else {
                    List<String> pictureUrlList = snapshot.data as List<String>;

                    return Scaffold(
                      backgroundColor: Colors.grey[400],
                      resizeToAvoidBottomInset: true,
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
                                        color: Colors.grey[400],
                                        child: InkWell(
                                          onTap: () {
                                            print(MediaQuery.of(context)
                                                .size
                                                .height);
                                            print(
                                                _bannerAd.size.height.toDouble());
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PictureItem(
                                                            imageUrl:
                                                                pictureUrlList[
                                                                    index])));
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl: pictureUrlList[index],
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Card(
                                                        elevation: 10,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                            side: const BorderSide(width: 3, color: Colors.grey)),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            //border: Border.all(width: 2,color: Colors.grey),
                                                            borderRadius:
                                                                BorderRadius.circular(10),
                                                            image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            placeholder: (context, url) =>
                                                const Center(child: BannerPlaceholder2()),
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
                  }
                }
              },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
