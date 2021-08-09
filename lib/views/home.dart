import 'package:flutter/material.dart';
import 'package:test_ilyes/services/database.dart';
import 'package:test_ilyes/views/create_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<QuerySnapshot>? cardStream;
  DatabaseService databaseService = new DatabaseService();

  Widget cardList() {
    return Container(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: cardStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data!.documents.length,
                      itemBuilder: (context, index) {
                        return Card(
                          title:
                              snapshot.data!.documents[index].data['cardTitle'],
                          imageUrl: snapshot
                              .data!.documents[index].data['cardImgUrl'],
                          description:
                              snapshot.data!.documents[index].data['cardDescription'],
                        );
                      });
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    databaseService.getCardData().then((value) {
      print(value.toString());
      setState(() {
        cardStream = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home")),
      ),
      body: cardList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateCard()));
        },
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String imageUrl, title, description;

  Card({
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      margin: EdgeInsets.all(10),
      height: 130,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Image.network(
              imageUrl ?? "https://c8.alamy.com/compfr/2bhg705/images-conceptuelles-colorees-2bhg705.jpg",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              color: Colors.black26,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title ?? "card",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      description ?? "desc",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
