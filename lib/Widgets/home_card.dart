import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  final Function onTap;

  const HomeCard({Key? key,required this.title,required this.description,required this.icon,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 6,
        child: InkWell(
          borderRadius: BorderRadius.circular(4.0),
          onTap: onTap as void Function()?,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SvgPicture.asset(icon, color: MyColors.primary,height: 48,),
                const SizedBox(height: 16,),
                AutoSizeText(title, style: const TextStyle(fontFamily: "SemiBold", fontSize: 16),maxLines: 1,textAlign: TextAlign.center,),
                const SizedBox(height: 6,),
                AutoSizeText(description,maxLines: 2, style: const TextStyle(fontSize: 14, color: Colors.grey,),textAlign: TextAlign.center,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
