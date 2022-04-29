// ignore_for_file: file_names, must_be_immutable

import 'package:dr_bankawy/models/product.dart';
import 'package:dr_bankawy/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dr_bankawy/services/store.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';

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

  AddProduct({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size mobileSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          // padding: EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(
              height: mobileSize.height * 0.1,
            ),
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
              },
              hint: 'الهاتف',
              type: TextInputType.number,
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
            // Todo: add button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () {
                  if (true) {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();
                      try {
                        _store.addProduct(Product(
                            pName: _name,
                            pImage: _image,
                            pInterest: _interest,
                            pDescription: _description,
                            pPhone: _phone,
                            pLatitude: _latitude,
                            pLongitude: _longitude,
                            pPapers: _papers,
                            pDuration: _duration,
                            pCategory: 'jackets'));

                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("تنبيه"),
                            content: const Text("تمت اضافة القرض بنجاح"),
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
                    print(
                        '$_name  \n $_image \n $_interest \n $_duration \n $_description \n $_papers \n $_papers \n $_phone \n $_longitude \n $_latitude}');
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
                  'اضافة القرض',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    // fontSize: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
