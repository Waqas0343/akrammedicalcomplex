import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeWidget extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const HomeWidget({Key key, this.icon, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (size.width*0.33) - 24, // 32 is padding
        color: Colors.transparent,
        child: Column(
          children: [
            SvgPicture.asset(icon, height: 40,),
            const SizedBox(height: 8,),
            Text(title, textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold, height: 1.3, fontSize: 12),maxLines: 2,)
          ],
        ),
      ),
    );
  }
}
