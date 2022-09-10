import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _txtCost = TextEditingController();
  bool _round = false;
  var radioGroup = {"Amazing": 20, "Good": 18, "Okay": 15};
  var _total = 0.0;
  int? currentRadio;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                controller: _txtCost,
                keyboardType: TextInputType.number,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  fillColor: Colors.green,
                  icon: Icon(
                    Icons.business,
                    color: Colors.green,
                  ),
                  labelText: "Cost of Service",
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dinner_dining, color: Colors.green),
            title: Text("How was the service?"),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: radioGroupGenerator(),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.credit_card,
              color: Colors.green,
            ),
            title: Text("Round up tip"),
            trailing: Switch(
                value: _round,
                onChanged: (value) {
                  setState(() {});
                  _round = !_round;
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () {
                  _total = _tipCalculation();
                  print(_round);
                  setState(() {});
                },
                child: Text("CALCULATE")),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Text("Tip Amount ${_total.toStringAsFixed(2)}"))
        ],
      ),
    );
  }

  radioGroupGenerator() {
    return radioGroup.entries
        .map(
          (radioElement) => ListTile(
            leading: Radio(
              value: radioElement.value,
              groupValue: currentRadio,
              onChanged: (int? selected) {
                currentRadio = selected;
                setState(() {});
              },
            ),
            title:
                Text("${radioElement.key}  ${radioElement.value.toString()}%"),
          ),
        )
        .toList();
  }

  double _tipCalculation() {
    _total = double.parse(_txtCost.text) * (currentRadio! / 100);
    if (_round) {
      return _total.ceil().toDouble();
    }
    return _total;
  }
}
