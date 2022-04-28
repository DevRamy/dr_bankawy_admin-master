// ignore_for_file: must_be_immutable, file_names

import 'package:dr_bankawy/constants.dart';
import 'package:dr_bankawy/models/product.dart';
import 'package:dr_bankawy/services/store.dart';
import 'package:dr_bankawy/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  // todo: values
  String _name;
  String _interest;
  String _description;
  String _image;
  int _phone;
  double _latitude;
  double _longitude;
  String _duration;
  String _papers;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();

  EditProduct({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    Size mobileSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: mobileSize.height * 0.1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Todo: Page title
                const Center(
                  child: Text(
                    "قرض جديد",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: bank name
                CustomTextField(
                  hint: 'اسم البنك',
                  type: TextInputType.text,
                  onClick: (value) {
                    _name = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: bank image
                CustomTextField(
                  onClick: (value) {
                    _image = value;
                  },
                  type: TextInputType.text,
                  hint: 'صورة البنك',
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: interest
                CustomTextField(
                  onClick: (value) {
                    _interest = value;
                  },
                  type: TextInputType.text,
                  hint: 'الفائدة',
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: duration
                CustomTextField(
                  onClick: (value) {
                    _duration = value;
                  },
                  type: TextInputType.text,
                  hint: 'مدة القرض',
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: description
                CustomTextField(
                  onClick: (value) {
                    _description = value;
                  },
                  type: TextInputType.multiline,
                  hint: 'الوصف',
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: papers
                Container(
                  width: mobileSize.width,
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: CustomTextField(
                    onClick: (value) {
                      _papers = value;
                    },
                    type: TextInputType.multiline,
                    hint: 'الأوراق المطلوبة',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: phone
                CustomTextField(
                  onClick: (value) {
                    _phone = int.parse(value);
                    ;
                  },
                  type: TextInputType.number,
                  hint: 'الهاتف',
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: location
                const Center(
                  child: Text(
                    "الموقع",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: mobileSize.width,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: mobileSize.width / 2,
                        child: CustomTextField(
                          onClick: (value) {
                            _latitude = double.parse(value);
                          },
                          type: TextInputType.number,
                          hint: ' latitude',
                        ),
                      ),
                      SizedBox(
                        width: mobileSize.width / 2,
                        child: CustomTextField(
                          onClick: (value) {
                            _longitude = double.parse(value);
                          },
                          type: TextInputType.number,
                          hint: ' longitude',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                FlatButton(
                  onPressed: () {
                    if (true) {
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();

                        try {
                          _store.editProduct({
                            kProductName: _name,
                            kProductImage: _image,
                            kProductInterest: _interest,
                            kProductDescription: _description,
                            kProductPhone: _phone,
                            kProductLongitude: _longitude,
                            kProductLatitude: _latitude,
                            kProductPapers: _papers,
                            kProductDuration: _duration,
                          }, product.pId);

                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("تنبيه"),
                              content: const Text("تمت تعديل البيانات بنجاح"),
                              actions: [
                                FlatButton(
                                  child: const Text("حسنا"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        } catch (e) {
                          print(e);
                        }
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("تنبيه"),
                          content: const Text("الرجاء ملئ البينات المطلوبة"),
                          actions: [
                            FlatButton(
                              child: const Text("حسنا"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    'تعديل القرض',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
