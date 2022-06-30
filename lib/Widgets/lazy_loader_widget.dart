import 'package:flutter/material.dart';

class LazyLoader extends StatelessWidget {
  const LazyLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width*0.2, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(
            height: 26.0,
            width: 26.0,
            child: CircularProgressIndicator(strokeWidth: 3,),
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            "Please wait..",
            style: TextStyle(
                fontSize: 14,
                color: Colors.grey
            ),
          ),
        ],
      ),
    );
  }
}
