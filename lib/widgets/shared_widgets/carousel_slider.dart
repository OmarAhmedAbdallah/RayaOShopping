import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/Model/home_slider.dart';
import 'package:oshopping/providers/home_slider_provider.dart';

// final List<String> imgList = [
//   'https://humannature.com.sg/images/dishwashing-688x491_2.jpg',
//   'https://i1.wp.com/myfaayda.com/wp-content/uploads/2018/03/Tata-Range-of-Products-Lowest-Price-online.jpg',
//   'https://i1.wp.com/myfaayda.com/wp-content/uploads/2018/03/Tata-Range-of-Products-Lowest-Price-online.jpg',
// ];
List<HomeSlider> imgList = [];

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {});
  }
}

List<Widget> getimageSliderWidget() {
  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container( 
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item.imagePath,
                          fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ), 
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  return imageSliders;
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  int firstTime = 0;
  Future _getHomeSlider;
  @override
  Widget build(BuildContext context) {
    if (firstTime == 0) {
      final homeSliderData = HomeSliderProvider();
      _getHomeSlider = homeSliderData.getHomeSlider();
      firstTime = 1;
    }
    return Container(
      child: FutureBuilder(
        future: _getHomeSlider,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            imgList = snapshot.data;
            return Column(
              children: <Widget>[
                Container(
                  height: 150,
                  width: 450,
                  child: CarouselSlider(
                    items: getimageSliderWidget(),
                    options: CarouselOptions(
                      enableInfiniteScroll: imgList.length == 1 ? false : true,
                      autoPlay: imgList.length == 1 ? false : true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.map((url) {
                    int index = imgList.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color.fromRGBO(0, 0, 0, 0.9)
                            : Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
