import 'dart:convert';
import 'dart:io';

import 'package:amc/models/medical_record_model.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddHealthRecord extends StatefulWidget {
  const AddHealthRecord({Key? key}) : super(key: key);

  @override
  _AddHealthRecordState createState() => _AddHealthRecordState();
}

class _AddHealthRecordState extends State<AddHealthRecord> {
  File? file;
  String? prescriptionPath;
  late SharedPreferences preferences;

  List<String> types = ["Lab Report", "Prescription", "Other"];
  String? type, username;

  bool isTaped = true;
  String buttonText = "Save";

  final nameController = TextEditingController();
  final desController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode desFocus = FocusNode();

  var isNameEmpty = false;
  final _picker = ImagePicker();
  bool isLoading = true;


  double uploadingValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Add New"),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ListView(
              children: <Widget>[
                imageViewLayout(),
                attachmentLayout(),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  focusNode: nameFocus,
                  maxLength: 35,
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      setState(() {
                        isNameEmpty = false;
                      });
                    }
                  },
                  onSubmitted: (text) {
                    nameFocus.unfocus();
                    FocusScope.of(context).requestFocus(desFocus);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Document Name",
                    counterText: "",
                    errorText: isNameEmpty ? "Required" : null,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.01, 0.01],
                        colors: [MyColors.primary, Colors.white]),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: DropdownButtonHideUnderline(

                      child: DropdownButton(
                          hint: const Text("Document Type"),
                          isExpanded: true,
                          value: type,
                          items: types.map((e) {
                            return DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),

                          onChanged: (dynamic type) {
                            setState(() {
                              this.type = type;
                            });
                          }),

                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                  minLines: 4,
                  maxLength: 250,
                  controller: desController,
                  focusNode: desFocus,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Description",
                      counterText: ""),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed:isTaped ? () => upload():null,
                  child: Text(
                    buttonText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget imageViewLayout (){
    return file != null
        ? SizedBox(
        height: 200,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,),
                ]),
                padding: const EdgeInsets.only(bottom: 12),
                child: Image.file(file!,),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  setState(() {
                    file = null;
                    isLoading = false;
                    uploadingValue = 0.0;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  color: Colors.grey.withOpacity(0.8),
                  child: const Icon(Icons.close),
                ),
              ),
            ),

            isLoading ? Align(alignment: Alignment.bottomCenter, child: LinearPercentIndicator(
              lineHeight: 18.0,
              percent: uploadingValue,
              center: Text("${(uploadingValue * 100).toInt()} %",style: const TextStyle(color: Colors.white,fontSize: 12),),
              barRadius: const Radius.circular(8),
              progressColor: MyColors.primary,
            )) : const SizedBox.shrink(),
          ],
        ))
        : const SizedBox.shrink();
  }

  Widget attachmentLayout() {
    return file == null
        ? Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Card(
                margin: const EdgeInsets.all(0),
                elevation: 0,
                color: Colors.white,
                child: InkWell(
                  onTap: () async {
                    var image = await _picker.pickImage(
                        source: ImageSource.camera);
                    if (image != null) {
                      setState(() {
                        file = File(image.path);
                      });
                      uploadImage(file!);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const <Widget>[
                        Icon(
                          Icons.camera,
                          size: 38,
                          color: MyColors.primary,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text("Camera")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 1,
              child: Card(
                elevation: 0,
                margin: const EdgeInsets.all(0),
                color: Colors.white,
                child: InkWell(
                  onTap: () async {
                    var image = await _picker.pickImage(
                        source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        file = File(image.path);
                      });
                      uploadImage(file!);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const <Widget>[
                        Icon(
                          Icons.image,
                          size: 38,
                          color: MyColors.primary,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text("Gallery")
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
        : const SizedBox.shrink();
  }

  @override
  void initState() {
    super.initState();
    getPrefrences();
  }

  void upload() async {
    disableButton();
    String name = nameController.text.trim();
    String description = desController.text.trim();
    nameFocus.unfocus();
    desFocus.unfocus();


    if (!await Utilities.isOnline()) {
      enableButton();
      Utilities.internetNotAvailable(context);
      return;
    }

    if (name.isEmpty) {
      enableButton();
      setState(() {
        isNameEmpty = true;
      });
      return;
    }


    if (type == null) {
      enableButton();
      Utilities.showToast("Prescription type required");
      return;
    }

    if (file == null ){
      enableButton();
      Utilities.showToast("attachment required");
      return;
    } else {
      if (isLoading){
        enableButton();
        Utilities.showToast("Image Uploading...");
        return;
      }
    }


    Loading.build(context, false);
    String response = await Utilities.httpPost(
        ServerConfig.healthRecordSave +
            "&Username=$username" +
            "&attachment=$prescriptionPath" +
            "&FileName=$name" +
            "&RecordType=$type" +
            "&Description=$description");
    Loading.dismiss();

    if (response != "404") {

      Map<String, dynamic> json = jsonDecode(response);

      HealthRecord healthRecord = HealthRecord.fromJson(json["Response"]["Response"]["document"]);
      healthRecord.sharedWithUsernameAndName = [];
      Navigator.pop(context, healthRecord);
    } else {
      Utilities.showToast("Something went wrong");
    }
    enableButton();
  }

  void uploadImage(File file) async {


    setState(() {
      isLoading = true;
    });

    Dio dio = Dio();

    FormData imageFormData = FormData.fromMap({
      "Systemkey" : ServerConfig.systemKey,
      "userid" : username,
      "file": await MultipartFile.fromFile(file.path, filename: 'file.jpg'),
    });

    var response = await dio.post(ServerConfig.uploadImages, data: imageFormData,
      onSendProgress: (int sent, int total) {
        setState(() {
          uploadingValue = (sent / total);
        });
      },);

    if (response.statusCode == 200){
      setState(() {
        isLoading = false;
        uploadingValue =0.0;
      });
      prescriptionPath = response.data["Response"]["Response"];
    }

  }

  void getPrefrences() async {
    preferences = await SharedPreferences.getInstance();
    username = preferences.getString(Keys.username);
  }

  void disableButton() {
    setState(() {
      isTaped = false;
    });
  }

  void enableButton() {
    setState(() {
      isTaped = true;
    });
  }


}