import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quotes/Constants/colors.dart';
import 'package:quotes/Controller/homeController.dart';
import 'package:quotes/View/RandomQuotePage.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/quotes.svg",),
            SizedBox(width: 5,),
            Text(
              "quotes",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  fontFamily: "CalibergroteskBold"
              ),
            ),
          ],
        ),
        leadingWidth: 80,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
                                color: secondColor
                            ),
                          ),
                        ),
                        Text(
                          "words",
                          style: TextStyle(
                              fontSize: 55,
                              fontFamily: "CalibergroteskBold"
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 30,
                            width: 250,
                            decoration: BoxDecoration(
                                color: secondColor
                            ),
                          ),
                        ),
                        Positioned(
                          top: -5,
                          child: Text(
                            "inspire you",
                            style: TextStyle(
                                fontSize: 55,
                                fontFamily: "CalibergroteskBold"
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15,),
                  Text(
                    "Today Quote",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "IrishbelleSans"
                    ),
                  ),
                  SizedBox(height: 5,),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: whiteColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          margin: EdgeInsets.symmetric(vertical: 20),
                          padding: EdgeInsets.all(10),
                          child: Center(),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: whiteColor.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          padding: EdgeInsets.all(10),
                          child: Center(),
                        ),
                        GetX<HomeController>(
                          init: HomeController()..getTodayQuote(),
                          builder: (HomeController controller) {
                          return RepaintBoundary(
                            key: controller.repaintKey,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.all(10),
                              child: Stack(
                                      children: [
                                        Positioned(
                                          left: -10,
                                          top: 0,
                                          child: SvgPicture.asset("assets/icons/quotes.svg", color: mainColor.withOpacity(0.5), width: 225,),
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(height: 20,),
                                            Row(
                                              children: [
                                                SizedBox(width: 10,),
                                                CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(controller.todayQuote.value!.authorImage.toString()),
                                                ),
                                                SizedBox(width: 10,),
                                                Text(
                                                  controller.todayQuote.value!.author.toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w800,
                                                      fontFamily: "IrishbelleScript"
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Expanded(
                                              child: LayoutBuilder(
                                                builder: (context, containers) => Text(
                                                  controller.todayQuote.value!.quote.toString(),
                                                  style: TextStyle(
                                                      fontSize: containers.maxWidth/12,
                                                      fontFamily: "IrishbelleSans"
                                                  ),
                                                  maxLines: 10,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                          ],
                                        )
                                      ],
                                    ),
                            ),
                          );
                          }
                        ),
                        GetX<HomeController>(
                            builder: (HomeController controller) {
                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("${controller.todayQuote.value!.quote}", style: TextStyle(fontSize: 0),),
                                      IconButton(
                                        onPressed: (){
                                          Share.share("${controller.todayQuote.value!.quote}\n-${controller.todayQuote.value!.author}");
                                        },
                                        icon: SvgPicture.asset("assets/icons/share.svg", width: 35, color: blackColor.withOpacity(0.6),),
                                      ),
                                      Text("${controller.todayQuote.value!.quote}", style: TextStyle(fontSize: 0),),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GetX<HomeController>(
              builder: (HomeController controller) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: secondColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                margin: EdgeInsets.symmetric(vertical: 20),
                                padding: EdgeInsets.all(10),
                                child: Center(),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: secondColor.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                padding: EdgeInsets.all(10),
                                child: Center(),
                              ),
                              InkWell(
                                onTap: (){
                                  // controller.getRandomQuote();
                                  // controller.takeScreenShot();
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        child: RandomQuotePage(),
                                        type: PageTransitionType.bottomToTop
                                    ),
                                  );
                                  controller.getRandomQuote();
                                  // controller.takeScreenShot();
                                  // controller.gettt();
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: secondColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  padding: EdgeInsets.all(10),
                                  child: Center(
                                    child: Text(
                                      "Get New Quote!${controller.counter}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: "IrishbelleSans"
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
