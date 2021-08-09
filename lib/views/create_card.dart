import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:random_string/random_string.dart';
import 'package:test_ilyes/services/database.dart';
import 'package:test_ilyes/views/home.dart';

class CreateCard extends StatefulWidget {
  const CreateCard({Key? key}) : super(key: key);

  @override
  _CreateCardState createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String imageUrl = "", cardTitle = "", cardDescription = "";

  bool isLoading = false;
  String cardId = "";

  createCard() {
    print("yesss");
    cardId = randomAlphaNumeric(16);
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> cardData = {
        "cardImgUrl": imageUrl,
        "cardTitle": cardTitle,
        "cardDescription": cardDescription
      };

      databaseService.addCardData(cardData, cardId).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Card"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                TextFormField(
                  validator: (val) => val!.isEmpty ? "enter Image" : null,
                  decoration: InputDecoration(hintText: "Card Image Url"),
                  onChanged: (val) {
                    imageUrl = val;
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? "enter Card Title" : null,
                  decoration: InputDecoration(hintText: "Card Title"),
                  onChanged: (val) {
                    cardTitle = val;
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? "enter description" : null,
                  decoration: InputDecoration(hintText: "Card description"),
                  onChanged: (val) {
                    cardDescription = val;
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    createCard();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24)),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 48,
                    child: Text(
                      "Create Card",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            )),
      ),
    );
  }
}
