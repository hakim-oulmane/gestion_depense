import 'package:expenditure_management/Tools/Methods.dart';
import 'package:expenditure_management/Tools/Property.dart';
import 'package:flutter/material.dart';

class AddDepense extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddDepenseState();

}

class _AddDepenseState extends State<AddDepense> {

  String _categorieValue;

  var _formKey = GlobalKey<FormState>();
  TextEditingController _montantControl = TextEditingController();
  TextEditingController _datePaiementControl = TextEditingController();

  @override
  void initState() {
    _categorieValue = CATEGORIE_DEPENSE[0]["name"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            primary: true,
            children: <Widget>[
              title,
              montant,
              categorie,
            ],
          ),
        ),
      ),
    );
  }

  Widget get title {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text("Ajouter des dépenses", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
    );
  }

  Widget get montant {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          validator: (String value) {
            String msg = "Montant invalide";
            return (int.parse(value) <= 0) ? null : msg;
          },
          controller: _montantControl,
          style: TEXT_STYLE,
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
          decoration: InputDecoration(
              labelText: "Montant",
              labelStyle: TEXT_STYLE,
              hintText: "Entrez le montant",
              contentPadding: EdgeInsets.only(
                  top: 15.0,
                  left: 10.0,
                  right: 10.0,
                  bottom: 15.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.0),
              )),
        ));
  }

  Widget get datePaiement {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: (String value) {
          String msg = "Date invalide";
          return Methods.valideDate(value) &&
              Methods.getDateFromString(value).isAfter(DateTime.now()) ? null : msg;
        },
        controller: _datePaiementControl,
        style: TEXT_STYLE,
        inputFormatters: [DateInputFormatter(),],
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
            labelText: "Date transaction",
            labelStyle: TEXT_STYLE,
            suffixIcon: GestureDetector(
              onTap: () => _selectDate(context),
              child: Icon(Icons.date_range),
            ),
            hintText: "Choisissez une date",
            contentPadding: EdgeInsets.only(
                top: 15.0,
                left: 10.0,
                right: 10.0,
                bottom: 15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.0),
            )),

      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {

    final DateTime Picked = await showDatePicker(
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: DateTime.now().add(Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 100)
    );
    if (Picked != null && Picked != _datePaiementControl.text) {
      setState(() => _datePaiementControl.text = Methods.getStringFromDate(Picked));
    }
  }

  Widget get categorie {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 15, right: 15),
          child: Text("Catégorie", style: LABEL_STYLE,),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(bottom: 25.0,),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(3.0))
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              icon: Container(),
              underline: Container(),
              isDense: true,
              elevation: 8,
              value: _categorieValue ?? CATEGORIE_DEPENSE[0],
              onChanged: (String newValue) {
                setState(() => _categorieValue = newValue);
                debugPrint(newValue);
              },
              items: CATEGORIE_DEPENSE.map<DropdownMenuItem<String>>((Map map) {
                return DropdownMenuItem<String>(
                  value: map["name"],
                  child: ListTile(
                    dense: true,
                    leading: Icon(map["icon"]),
                    title: Text(map["name"])
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

}