import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //get datas of textFields
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String infoText = "Informe seus dados.";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      infoText = "Informe seus dados.";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double w = double.parse(weightController.text);
      double h = double.parse(heightController.text) / 100;
      double imc = _imc(w, h);
      print(imc);
      if (imc < 18.6) {
        infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        infoText = "Obesidade grau I  (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        infoText = "Obesidade grau II  (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 39.9) {
        infoText = "Obesidade grau III  (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  double _imc(double n1, double n2) {
    return n1 / (n2 * n2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            //centralizar objetos
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 150.0, color: Colors.lightGreen[500]),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso(kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 20.0),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu peso";
                  }else if(double.parse(value) < 1)
                    return "Peso tem que ser maior que 0.";
                  },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura(cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                ),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua altura";
                  }else if(double.parse(value) < 30){
                    return "Insira altura maior que 30cm";
                  }else if(double.parse(value) > 250){
                    return "É um gigante? altura tem que ser inferior à 250cm";
                  }
                },

              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 30.0,
                  child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.lightGreen,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                ),
              ),
              Text(
                infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
