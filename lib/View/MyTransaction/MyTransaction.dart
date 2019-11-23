import 'package:backdrop/backdrop.dart';
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Tools/Methods.dart';
import 'package:expenditure_management/Tools/Property.dart';
import 'package:expenditure_management/View/Home/MyHomepage.dart';
import 'package:expenditure_management/components/SelectPeriode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:pattern_formatter/date_formatter.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ListTransaction.dart';

class MyTransaction extends StatefulWidget {

  DateTime periode;
  MyTransaction(this.periode);

  @override
  State<StatefulWidget> createState() => _MyTransactionState(periode);

}

class _MyTransactionState extends State<MyTransaction> {

  RecordModel _recordModel;
  DateTime _periode;
  _MyTransactionState(this._periode);


  DateTime MIN_DATETIME = DateTime(DateTime.now().year - 30);
  DateTime MAX_DATETIME = DateTime.now();
  DateTime INIT_DATETIME = DateTime.now();
  String _format = 'dd/MM/yyyy';
  DateTime _dateDebut;
  DateTime _dateFin;

  TextEditingController _dateDebutControl = TextEditingController();
  TextEditingController _dateFinControl = TextEditingController();

  @override
  void initState() {
    ///load the list of records
    _recordModel = RecordModel();
    _recordModel.loadListRecord();
    _dateDebut = widget.periode;
    _dateFin = DateTime.now();
    _dateDebutControl.text = Methods.getStringFromDate(_dateDebut);
    _dateFinControl.text = Methods.getStringFromDate(_dateFin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => MyHomePage(periode: widget.periode,))),
      child: SafeArea(
        child: ScopedModel(
          model: _recordModel,
          child: BackdropScaffold(

            title: Text('Mes transactions'),
            iconPosition: BackdropIconPosition.action,
            // Height of front layer when backlayer is shown.
//            headerHeight: 60.0,
            frontLayer: ListTransaction(_recordModel, widget.periode, _dateDebut, _dateFin),
            backLayer: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 10,),

                  ///date debut
                  Expanded(
                      child: TextFormField(
                        validator: (String value) {
                          String msg = "Date invalide";
                          return Methods.valideDate(value) &&
                              Methods.getDateTimeFromString(value).isBefore(DateTime.now()) ? null : msg;
                        },
                        controller: _dateDebutControl,
                        onTap: () => _showDateTimePicker("dateDebut"),
                        readOnly: true,
                        style: TextStyle(color: Colors.white),
                        inputFormatters: [DateInputFormatter(),],
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white,),
                          ),
                          labelText: "Date début",
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "Choisissez une date",
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10.0,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                          )),
                      )
                  ),
                  SizedBox(width: 10,),

                  ///date fin
                  Expanded(
                      child: TextFormField(
                        validator: (String value) {
                          String msg = "Date invalide";
                          return Methods.valideDate(value) &&
                              Methods.getDateTimeFromString(value).isBefore(DateTime.now()) ? null : msg;
                        },
                        controller: _dateFinControl,
                        readOnly: true,
                        onTap: () => _showDateTimePicker("dateFin"),
                        style: TextStyle(color: Colors.white),
                        inputFormatters: [DateInputFormatter(),],
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white,),
                            ),
                            labelText: "Date fin",
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: "Choisissez une date",
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 10.0,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            )),
                      )
                  ),
                  SizedBox(
                      width: 10,
                      child: SelectPeriode(
                        icon: Icons.arrow_drop_down,
                        periode: widget.periode,
                        onChangePeriode: (value)=> setState(() {
                          _dateDebut = value;
                          _dateFin = DateTime.now();
                          _dateDebutControl.text = Methods.getStringFromDate(_dateDebut);
                          _dateFinControl.text = Methods.getStringFromDate(_dateFin);
                        }),
                      )
                  ),
                ],
              ),
            ),

//              floatingActionButton: FloatingActionButton(
//                onPressed: () => Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => AddTransaction(_recordModel, widget.periode))),
//                child: Icon(Icons.add, color: Colors.white,),
//                backgroundColor: SECOND_COLOR,
//              ),
            ),
        ),
      )
    );
  }

  /// Display datetime picker.
  void _showDateTimePicker(String param) {
    DatePicker.showDatePicker(
      context,
      minDateTime: param == "dateDebut" ? MIN_DATETIME : _dateDebut,
      maxDateTime: param == "dateDebut" ? _dateFin : MAX_DATETIME,
      initialDateTime: param == "dateDebut" ? _dateDebut : _dateFin,
      dateFormat: _format,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        cancel: Text("Annuler", style: TextStyle(color: SECOND_COLOR), textScaleFactor: 1.3,),
        confirm: Text("Ok", style: TextStyle(color: FIRST_COLOR), textScaleFactor: 1.3,),
      ),
      pickerMode: DateTimePickerMode.datetime,
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          if( param == "dateDebut" ) {
            _dateDebut = dateTime;
            _dateDebutControl.text = Methods.getStringFromDate(dateTime);
          }
          else {
            _dateFin = dateTime;
            _dateFinControl.text = Methods.getStringFromDate(dateTime);
          }
        });
      },
    );
  }
}