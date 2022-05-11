// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names

import 'package:dr_bankawy/models/product.dart';
import 'package:dr_bankawy/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dr_bankawy/services/store.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';

  // todo: values
  final TextEditingController name_Controller = TextEditingController();
  final TextEditingController interest_Controller = TextEditingController();
  final TextEditingController description_Controller = TextEditingController();
  final TextEditingController image_Controller = TextEditingController();
  final TextEditingController phone_Controller = TextEditingController();
  final TextEditingController latitude_Controller = TextEditingController();
  final TextEditingController longitude_Controller = TextEditingController();
  final TextEditingController duration_Controller = TextEditingController();
  final TextEditingController papers_Controller = TextEditingController();

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
              controller: name_Controller,
            ),
            const SizedBox(
              height: 10,
            ),
            // Todo: bank image
            CustomTextField(
              controller: image_Controller,
              hint: 'صورة البنك',
            ),
            const SizedBox(
              height: 10,
            ),
            // Todo: interest
            CustomTextField(
              controller: interest_Controller,
              hint: 'الفائدة',
            ),
            const SizedBox(
              height: 10,
            ),
            // Todo: duration
            CustomTextField(
              controller: duration_Controller,
              hint: 'مدة القرض',
            ),
            const SizedBox(
              height: 10,
            ),
            // Todo: description
            CustomTextField(
              controller: description_Controller,
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
                controller: papers_Controller,
                hint: 'الأوراق المطلوبة',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Todo: phone
            CustomTextField(
              controller: phone_Controller,
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
                      controller: latitude_Controller,
                      hint: ' latitude',
                    ),
                  ),
                  SizedBox(
                    width: mobileSize.width / 2,
                    child: CustomTextField(
                      controller: longitude_Controller,
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
                  if (name_Controller.text.isNotEmpty ||
                      image_Controller.text.isNotEmpty ||
                      interest_Controller.text.isNotEmpty ||
                      description_Controller.text.isNotEmpty ||
                      phone_Controller.text.isNotEmpty ||
                      longitude_Controller.text.isNotEmpty ||
                      latitude_Controller.text.isNotEmpty ||
                      papers_Controller.text.isNotEmpty ||
                      duration_Controller.text.isNotEmpty) {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();
                      try {
                        _store.addProduct(Product(
                          pName: name_Controller.text,
                          pImage: image_Controller.text,
                          pInterest: interest_Controller.text,
                          pDescription: description_Controller.text,
                          pPhone: int.parse(phone_Controller.text),
                          pLatitude: double.parse(longitude_Controller.text),
                          pLongitude: double.parse(latitude_Controller.text),
                          pPapers: papers_Controller.text,
                          pDuration: duration_Controller.text,
                        ));

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
