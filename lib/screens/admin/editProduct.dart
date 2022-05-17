// ignore_for_file: must_be_immutable, file_names, non_constant_identifier_names, deprecated_member_use

import 'package:dr_bankawy/constants.dart';
import 'package:dr_bankawy/models/product.dart';
import 'package:dr_bankawy/services/store.dart';
import 'package:dr_bankawy/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
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
                    "تعديل القرض",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: bank name
                CustomTextField(
                  hint: "اسم البنك",
                  controller: name_Controller..text = product.pName,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: bank image
                CustomTextField(
                  controller: image_Controller..text = product.pImage,
                  hint: 'صورة البنك',
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: interest
                CustomTextField(
                  controller: interest_Controller..text = product.pInterest,
                  hint: 'الفائدة',
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: duration
                CustomTextField(
                  controller: duration_Controller..text = product.pDuration,
                  hint: 'مدة القرض',
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: description
                CustomTextField(
                  controller: description_Controller
                    ..text = product.pDescription,
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
                    controller: papers_Controller..text = product.pPapers,
                    hint: 'الأوراق المطلوبة',
                    maxLines: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: phone
                CustomTextField(
                  controller: phone_Controller
                    ..text = product.pPhone.toString(),
                  hint: 'الهاتف',
                ),
                const SizedBox(
                  height: 10,
                ),
                // Todo: location
                const Center(
                  child: Text(
                    "الموقع",
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
                          keyboardType: TextInputType.number,
                          controller: latitude_Controller
                            ..text = product.pLatitude.toString(),
                          hint: ' latitude',
                        ),
                      ),
                      SizedBox(
                        width: mobileSize.width / 2,
                        child: CustomTextField(
                          keyboardType: TextInputType.number,
                          controller: longitude_Controller
                            ..text = product.pLongitude.toString(),
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
                          _store.editProduct({
                            kProductName: name_Controller.text,
                            kProductImage: image_Controller.text,
                            kProductInterest: interest_Controller.text,
                            kProductDescription: description_Controller.text,
                            kProductPhone: int.parse(phone_Controller.text),
                            kProductLongitude:
                                double.parse(longitude_Controller.text),
                            kProductLatitude:
                                double.parse(latitude_Controller.text),
                            kProductPapers: papers_Controller.text,
                            kProductDuration: duration_Controller.text,
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
