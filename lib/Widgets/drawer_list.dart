import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DrawerList extends StatelessWidget {
  final String title;
  final String icon;
  final Function onTap;
  final bool isBottomBorder;
  final bool isDropdown;

  const DrawerList({Key key, this.title, this.icon, this.onTap, this.isBottomBorder, this.isDropdown}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: InkWell(
        onTap: ()=> onTap(),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: isBottomBorder ?  Colors.grey.shade400 : Colors.transparent))
              ),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        icon,
                        width: 24,
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,),
                        ),
                      )
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}