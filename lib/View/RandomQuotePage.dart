import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quotes/View/HomePage.dart';
import 'package:share_plus/share_plus.dart';

import '../Constants/colors.dart';
import '../Controller/homeController.dart';

class RandomQuotePage extends StatelessWidget {
  const RandomQuotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: BackButton(
          onPressed: (){
            Navigator.pop(
              context,
              PageTransition(
                  child: HomePage(),
                  type: PageTransitionType.topToBottom
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
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
                      init: HomeController()..getRandomQuote(),
                      builder: (HomeController controller) {
                        return RepaintBoundary(
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
                                          backgroundImage: NetworkImage(controller.randomQuote.value!.authorImage.toString()),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          controller.randomQuote.value!.author.toString(),
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
                                          controller.randomQuote.value!.quote.toString(),
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
                                Text("${controller.randomQuote.value!.quote}", style: TextStyle(fontSize: 0),),
                                IconButton(
                                  onPressed: (){
                                    Share.share("${controller.randomQuote.value!.quote}\n-${controller.randomQuote.value!.author}");
                                  },
                                  icon: SvgPicture.asset("assets/icons/share.svg", width: 35, color: blackColor.withOpacity(0.6),),
                                ),
                                Text("${controller.randomQuote.value!.quote}", style: TextStyle(fontSize: 0),),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
            Expanded(
                child: Row(
                  children: [

                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
