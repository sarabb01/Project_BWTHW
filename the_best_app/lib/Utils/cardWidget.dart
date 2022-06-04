import 'package:flutter/material.dart';
import 'package:the_best_app/screens/Rewards/queryPage.dart';

class cardWidget extends StatelessWidget {
  final AssetImage input_image;
  final BuildContext context;
  final String input_text;
  final String input_query;

  cardWidget(this.context, this.input_image, this.input_text, this.input_query);
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      //height: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 3),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Ink.image(
              image: input_image,
              height: screenSize.height / 6,
              width: screenSize.width / 2.15,
              child: InkWell(
                onTap: () {
                  String selection = input_query;
                  Navigator.pushNamed(context, QueryPage.route,
                      arguments: selection);
                },
              ),
              fit: BoxFit.fill),
          Text(
            '${input_text}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }
}
