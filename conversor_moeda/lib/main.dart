import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const REQUEST = "https://api.hgbrasil.com/finance?key=08cbbcc3";

void main() async {

  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white
    )
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double dolar;
  double euro;

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  void realChanges(String text) {

    if (text.isEmpty) {
      this.clearAll();
      return;
    }

    double real = double.parse(text);
    dolarController.text = (real/dolar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
  }

  void dolarChanges(String text) {

    if (text.isEmpty) {
      this.clearAll();
      return;
    }

    double dolar = double.parse(text);
    realController.text = (dolar*this.dolar).toStringAsFixed(2);
    euroController.text = ((dolar * this.dolar)/euro).toStringAsFixed(2);
  }

  void euroChanges(String text) {

    if (text.isEmpty) {
      this.clearAll();
      return;
    }

    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = ((euro * this.euro)/dolar).toStringAsFixed(2);
  }

  void clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text("Carregando dados...",
                  style: TextStyle(color: Colors.amber,fontSize: 25.0),
                  textAlign: TextAlign.center,)
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text("Erro ao carregar dados!",
                        style: TextStyle(color: Colors.amber,fontSize: 25.0),
                        textAlign: TextAlign.center,)
                  );
                } else {
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];


                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on,size:150.0,color:Colors.amber),
                        buildTextField("Reais", "R\$", realController, realChanges),
                        Divider(),
                        buildTextField("Dolares", "US\$", dolarController,dolarChanges),
                        Divider(),
                        buildTextField("Euros", "EUR\$", euroController,euroChanges),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}


Future<Map> getData() async {
  http.Response response = await http.get(REQUEST);
  return json.decode(response.body);
}

Widget buildTextField(String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color:Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix,
    ),
    style: TextStyle(color: Colors.amber,fontSize: 25.0),
    controller: c,
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}