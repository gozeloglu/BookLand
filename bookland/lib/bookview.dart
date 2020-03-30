import 'package:flutter/material.dart';


class BookView extends StatelessWidget{
  static const String _title = 'BookView';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: BookViewStatefulWidget(),
    );    throw UnimplementedError();
  }

}

class BookViewStatefulWidget extends StatefulWidget{
  BookViewStatefulWidget({Key key}) : super(key: key);
  @override
  _BookViewState createState() => _BookViewState();

}
class _BookViewState extends State<BookViewStatefulWidget>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookland'),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              imageBook(),
              stars(),
              author(),
              fiyatBook(),
              sepeteEkleButton(),
            ],
          ),
        ),
      ),
    );
  }
  Widget imageBook(){
    return new Stack(
      children: <Widget>[
        Image.asset('assets/image/book.jpg', height: 300, width: 200,)
      ],
    );
  }
  Widget stars(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.black),
      ],
    );
  }
  Widget author(){
    return Text(
      'Orhan Pamuk',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,

      ),);
  }
  Widget fiyatBook(){
    var fiyatNum = Row(
      mainAxisAlignment: MainAxisAlignment.start,

      children: <Widget>[
        Text(
          '32,',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,

          ),
        ),
        Text(
          '90 TL',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
    var fiyat =
    Text(
      'Fiyat : ',
      style: TextStyle(
        fontSize: 25,
      ),
    );

    return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          fiyat,
          fiyatNum,
        ]
    );
  }
  Widget sepeteEkleButton(){
    return RaisedButton(
      onPressed: () {},
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(10.0),
        child: const Text(
            'Sepete Ekle',
            style: TextStyle(fontSize: 20)
        ),
      ),
    );
  }
  Widget comments(){
    // TODO comments gelecek ama nasıl olacak emin değilim
  }



}