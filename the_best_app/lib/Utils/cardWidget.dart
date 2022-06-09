import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:the_best_app/screens/RewardScreens/queryPage.dart';

class cardWidget extends StatelessWidget {
  final String input_image;
  //final AssetImage input_image;
  final BuildContext context;
  final String input_text;
  final String input_query;

  cardWidget(this.context, this.input_image, this.input_text, this.input_query);
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
        // height: screenSize.height / 4.6,
        // width: screenSize.width / 2.5,
        decoration: BoxDecoration(
            color: Colours.whiteSmoke, borderRadius: BorderRadius.circular(10)),
      ),
      Container(
        //height: double.infinity,
        decoration: BoxDecoration(
            //color: Colours.whiteSmoke,
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                String selection = input_query;
                Navigator.pushNamed(context, QueryPage.route,
                    arguments: selection);
              },
              child: Image.asset(input_image,
                  height: screenSize.height / 6,
                  width: screenSize.width / 2.4,

                  //     child: InkWell(
                  //   onTap: () {
                  //     String selection = input_query;
                  //     Navigator.pushNamed(context, QueryPage.route,
                  //         arguments: selection);
                  //   },
                  // ),
                  fit: BoxFit.fill),
            ),
            Text(
              '${input_text}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
    ]);
  }
}
