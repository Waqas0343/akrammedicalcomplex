import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Loading {

  static ProgressDialog pr;

  static build(BuildContext context, bool isDismissible){
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: isDismissible);
    pr.style(
      message: 'Please Wait...',
      insetAnimCurve: Curves.easeOut,
      progressWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );

    pr.show();
  }

  static dismiss(){
    pr.hide();
  }
}
