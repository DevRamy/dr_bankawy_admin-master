import 'package:dr_bankawy/constants.dart';
import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kThiredColor,
      child: Column(
        children: const [
          Image(
            height: 100,
            width: 100,
            image: AssetImage(
              'images/icons/buyicon.png',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'دليلك الاول',
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'في عالم القروض',
          )
        ],
      ),
    );
  }
}
