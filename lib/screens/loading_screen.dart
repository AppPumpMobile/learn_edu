import 'dart:async';
import 'package:eclass/localization/language_provider.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'bottom_navigation_screen.dart';
import '../common/global.dart';
import '../provider/home_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class LoadingScreen extends StatefulWidget {
  String token;
  LoadingScreen(this.token);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _visible = false;
  VideoPlayerController _controller;
  initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/splash.mp4');
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);

    /// initialize Intro.mp4
    _controller.initialize().then((_) => setState(() {}));

    /// play Intro.mp4
    _controller.play();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var token = await storage.read(key: "token");
      authToken = token;
      HomeDataProvider homeData =
          Provider.of<HomeDataProvider>(context, listen: false);
      await homeData.getHomeDetails(context);

      if (await storage.containsKey(key: 'selectedCurrency') &&
          await storage.containsKey(key: 'selectedCurrencyRate')) {
        selectedCurrency = await storage.read(key: 'selectedCurrency');
        selectedCurrencyRate =
            int.parse(await storage.read(key: 'selectedCurrencyRate'));
      } else {
        selectedCurrency = homeData.homeModel.currency.currency;
        selectedCurrencyRate = 1;
      }

      // Loading Languages
      LanguageProvider languageProvider =
          Provider.of<LanguageProvider>(context, listen: false);
      await languageProvider.loadData(context, loadScreen: false);
      changeLocale(context, languageProvider.languageCode);

      setState(() {
        authToken = token;
      });
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          _visible = true;
        });
      });
    });
  }

  @override
  void dispose() {
    /// dispose after closing screen
    _controller.dispose();
    super.dispose();
  }

  // Widget logoWidget() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     mainAxisSize: MainAxisSize.max,
  //     children: [
  //       AspectRatio(
  //         aspectRatio: _controller.value.aspectRatio,
  //         child: VideoPlayer(_controller),
  //       ),
  //       SizedBox(
  //         height: 20,
  //       ),
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           CircularProgressIndicator(
  //             valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF44A4A)),
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _visible == true
          ? MyBottomNavigationBar(
              pageInd: 0,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: //Image.asset('assets/splash.gif')
                      AspectRatio(
                        aspectRatio: _controller?.value?.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF44A4A)),
                ),
              ],
            ),
    );
  }
}
