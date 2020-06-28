import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/api/api_postal_code.dart';
import 'package:xlo/common/cep_field.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'package:xlo/screens/create/widgets/images_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Inserir anúncio"),
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            ImagesField(
              initialValue: [],
              onSaved: (images) {

              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Título *",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.grey,
                  fontSize: 18
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10)
              ),
              validator: (text) {
                if (text.isEmpty)
                  return "Campo obrigatorio";
                return null;
              },
              onSaved: (text) {

              },
            ),
            TextFormField(
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Descrição *",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.grey,
                  fontSize: 18
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10)
              ),
              validator: (text) {
                if (text.trim().isEmpty)
                  return "Campo obrigatorio";
                if (text.trim().length < 10)
                  return "Descrição muito curta";
                return null;
              },
              onSaved: (text) {

              },
            ),
            CepField(
              decoration: InputDecoration(
                  labelText: "CEP *",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.grey,
                      fontSize: 18
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10)
              ),
              onSaved: (address) {

              }
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Preço *",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.grey,
                  fontSize: 18
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10)
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false
              ),
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                RealInputFormatter(centavos: true)
              ],
              validator: (text) {
                if (text.isEmpty)
                  return "Campo obrigatorio";
                if (double.tryParse(text) == null)
                  return "Utilize valores validos";
                return null;
              },
              onSaved: (price) {

              },
            ),
            Container(
              height: 50,
              child: RaisedButton(
                color: Colors.pink,
                child: Text(
                  "Enviar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
