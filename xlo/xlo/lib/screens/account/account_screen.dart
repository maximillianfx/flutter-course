import 'package:flutter/material.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'package:xlo/screens/edit_account/edit_account_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text("Minha conta"),
        actions: <Widget>[
          FlatButton(
            child: const Text("Editar"),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditAccountScreen()
              ));
            },
          )
        ],
        elevation: 0,

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            alignment: Alignment.center,
            child: Text(
              "Maximillian Xavier",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Meus anúncios",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600
              ),
            ),
            onTap: () {

            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            title: Text(
                "Favoritos",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            onTap: () {

            },
            trailing: Icon(Icons.keyboard_arrow_right),
          )
        ],
      ),
    );
  }
}
