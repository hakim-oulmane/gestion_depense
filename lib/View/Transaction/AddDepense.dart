import 'dart:async';

import 'package:expenditure_management/Control/MouvementImpl.dart';
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Tools/Methods.dart';
import 'package:expenditure_management/Tools/Property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class AddDepense extends StatefulWidget {

  RecordModel recordModel;
  AddDepense(this.recordModel);

  @override
  State<StatefulWidget> createState() => _AddDepenseState();

}

class _AddDepenseState extends State<AddDepense> {

  final DateTime MIN_DATETIME = DateTime(DateTime.now().year - 30);
  final DateTime MAX_DATETIME = DateTime.now();
  final DateTime INIT_DATETIME = DateTime.now();
  String _format = 'dd/MM/yyyy HH:mm';
  DateTime _dateTime;
  String _categorieValue;

  var _formKey = GlobalKey<FormState>();
  TextEditingController _montantControl = TextEditingController();
  TextEditingController _dateControl = TextEditingController();
  TextEditingController _descriptionControl = TextEditingController();

  @override
  void initState() {
    _categorieValue = CATEGORIE_DEPENSE[0]["name"];
    _dateControl.text = Methods.getStringFromDateTime(DateTime.now());
    _dateTime = DateTime.now();
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
              description,
              date,
              button,
            ],
          ),
        ),
      ),
    );
  }

  Widget get title {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Text("Ajouter des dépenses", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
    );
  }

  Widget get montant {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          validator: (String value) {
            String msg = "Montant invalide";
            return value != "" && double.parse(Methods.formatMontant(value)) > 0 ? null : msg;
          },
          controller: _montantControl,
          style: TEXT_STYLE,
          inputFormatters: [ThousandsFormatter(allowFraction: true)],
          keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
          decoration: InputDecoration(
              labelText: "Montant",
              labelStyle: TEXT_STYLE,
              hintText: "Entrez le montant",
              suffix: Text("DA"),
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

  ///get categories
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
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey,),
                borderRadius: BorderRadius.all(Radius.circular(3.0))
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              icon: Container(),
              underline: Container(),
              isDense: false,
              elevation: 8,
              value: _categorieValue ?? CATEGORIE_DEPENSE[0],
              onChanged: (String newValue) {
                setState(() => _categorieValue = newValue);
              },
              items: CATEGORIE_DEPENSE.map<DropdownMenuItem<String>>((Map map) {
                return DropdownMenuItem<String>(
                  value: map["name"],
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        child: CircleAvatar(
                          child: Icon(map["icon"], color: Colors.white,),
                          backgroundColor: SECOND_COLOR,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(map["name"], style: TextStyle(fontSize: 16),),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  /// get date time widget
  Widget get date {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: TextFormField(
            validator: (String value) {
              String msg = "Date invalide";
              return Methods.valideDate(value) &&
                  Methods.getDateTimeFromString(value).isBefore(DateTime.now()) ? null : msg;
            },
            controller: _dateControl,
            onTap: _showDateTimePicker,
            readOnly: true,
            style: TEXT_STYLE,
            inputFormatters: [DateInputFormatter(),],
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
                labelText: "Date",
                labelStyle: TEXT_STYLE,
                hintText: "Choisissez une date",
                contentPadding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 10.0,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                )),

          )
        ),
        Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey
                ),
                borderRadius: BorderRadius.all(Radius.circular(3.0))
            ),
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            child: IconButton(
                icon: Icon(Icons.date_range, color: SECOND_COLOR, size: 30,),
                onPressed: _showDateTimePicker)
        )
      ],
    );
  }

  /// Display datetime picker.
  void _showDateTimePicker() {
    DatePicker.showDatePicker(
      context,
      minDateTime: MIN_DATETIME,
      maxDateTime: MAX_DATETIME,
      initialDateTime: _dateTime,
      dateFormat: _format,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        cancel: Text("Annuler", style: TextStyle(color: SECOND_COLOR), textScaleFactor: 1.3,),
        confirm: Text("Ok", style: TextStyle(color: FIRST_COLOR), textScaleFactor: 1.3,),
      ),
      pickerMode: DateTimePickerMode.datetime,
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
          _dateControl.text = Methods.getStringFromDateTime(dateTime);
        });
      },
    );
  }

  Widget get description {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          controller: _descriptionControl,
          style: TEXT_STYLE,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              labelText: "Description",
              labelStyle: TEXT_STYLE,
              hintText: "Entrez une description",
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

  Widget get button{
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20),
      child: RaisedButton(
        onPressed: () => valideForm(),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0,),
        child: Text("Enregistrer",
            textScaleFactor: 1.3,
            style: TEXT_STYLE_BUTTON
        ),
      )
    );
  }

  ///valid form
  Future valideForm() async {
    if( !_formKey.currentState.validate())
      return;

    Map data = {
      "montant": double.parse(Methods.formatMontant(_montantControl.text)),
      "categorie": _categorieValue,
      "description": _descriptionControl.text == "" ? null : _descriptionControl.text,
      "datetime": _dateTime
    };

    Future future = MouvementImpl().insertMouvement(data);
    future.timeout(Duration(seconds: 5),onTimeout: () {
      showToast("Echec de l'opération");
    });
    future.then((id) {
      if(id != null && id > 0){
        showToast("Dépense enregistrée");
        ///load the list of records
        widget.recordModel.loadListRecord();

        ///reset content form
        setState(() {
          _montantControl.clear();
          _categorieValue = "Nourriture";
          _descriptionControl.clear();
        });
      }
      else
        showToast("Echec de l'opération");
    }, onError: (e) {
      showToast("Echec de l'opération");
    });
  }

  ///display a toast
  void showToast(String message) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
      duration: Duration(seconds: 3),
    ));
  }

}