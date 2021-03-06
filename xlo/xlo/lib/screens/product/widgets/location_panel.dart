import 'package:flutter/material.dart';
import 'package:xlo/models/ad.dart';

class LocationPanel extends StatelessWidget {

  LocationPanel({this.ad});

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 18),
          child: Text(
            "Localização",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text("CEP"),
                  SizedBox(height: 12,),
                  Text("Município"),
                  SizedBox(height: 12,),
                  Text("Bairro")
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text('${ad.address.postalCode}'),
                    SizedBox(height: 12,),
                    Text('${ad.address.city}'),
                    SizedBox(height: 12,),
                    Text('${ad.address.district}')
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
