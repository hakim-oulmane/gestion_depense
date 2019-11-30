import 'package:expenditure_management/Service/Methods.dart';
import 'package:expenditure_management/Service/Property.dart';
import 'package:expenditure_management/components/SelectPeriode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:pattern_formatter/date_formatter.dart';

class FilterTransaction extends StatefulWidget {

  DateTime periode;
  DateTime dateDebut;
  DateTime dateFin;
  bool isDepenseCheck;
  bool isRevenuCheck;
  final Function(Map) onChangeFilter;

  FilterTransaction({@required this.dateDebut, @required this.dateFin,
    @required this.isDepenseCheck, @required this.isRevenuCheck,
    @required this.periode, @required this.onChangeFilter});

  @override
  _FilterTransactionState createState() => _FilterTransactionState();
}

class _FilterTransactionState extends State<FilterTransaction> {

  DateTime MIN_DATETIME = DateTime(DateTime.now().year - 30);
  DateTime MAX_DATETIME = DateTime.now();
  DateTime INIT_DATETIME = DateTime.now();
  String _format = 'dd/MM/yyyy';
  DateTime _dateDebut;
  DateTime _dateFin;
  bool depenseCheck;
  bool revenuCheck;

  TextEditingController _dateDebutControl = TextEditingController();
  TextEditingController _dateFinControl = TextEditingController();

  @override
  void initState() {
    _dateDebut = widget.dateDebut;
    _dateFin = widget.dateFin;
    _dateDebutControl.text = Methods.getStringFromDate(_dateDebut);
    _dateFinControl.text = Methods.getStringFromDate(_dateFin);
    depenseCheck = widget.isDepenseCheck;
    revenuCheck = widget.isRevenuCheck;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: 20,),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      depenseCheck = !depenseCheck;
                    });
                    callBack();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(3.0)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Dépense", style: TextStyle(color: Colors.white, fontSize: 26),),
                        depenseCheck ? Icon(Icons.check, color: Colors.white, size: 24,) : Container()
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      revenuCheck = !revenuCheck;
                    });
                    callBack();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(3.0)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Revenu", style: TextStyle(color: Colors.white, fontSize: 26),),
                        revenuCheck ? Icon(Icons.check, color: Colors.white, size: 24,) : Container()
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20,),
            ],
          ),
          SelectPeriode(
              icon: Icons.arrow_drop_down_circle,
              periode: widget.periode,
              onChangePeriode: (value){
                setState(() {
                  _dateDebut = value;
                  _dateFin = DateTime.now();
                  _dateDebutControl.text =
                      Methods.getStringFromDate(_dateDebut);
                  _dateFinControl.text =
                      Methods.getStringFromDate(_dateFin);
                });
                callBack();
              }
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),

              ///date debut
              Expanded(
                  child: TextFormField(
                    validator: (String value) {
                      String msg = "Date invalide";
                      return Methods.valideDate(value) &&
                          Methods.getDateTimeFromString(value)
                              .isBefore(DateTime.now())
                          ? null
                          : msg;
                    },
                    controller: _dateDebutControl,
                    onTap: () => _showDateTimePicker("dateDebut"),
                    readOnly: true,
                    style: TextStyle(color: Colors.white),
                    inputFormatters: [
                      DateInputFormatter(),
                    ],
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: "Date début",
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: "Choisissez une date",
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        )),
                  )),
              SizedBox(
                width: 10,
              ),

              ///date fin
              Expanded(
                  child: TextFormField(
                    validator: (String value) {
                      String msg = "Date invalide";
                      return Methods.valideDate(value) &&
                          Methods.getDateTimeFromString(value)
                              .isBefore(DateTime.now())
                          ? null
                          : msg;
                    },
                    controller: _dateFinControl,
                    readOnly: true,
                    onTap: () => _showDateTimePicker("dateFin"),
                    style: TextStyle(color: Colors.white),
                    inputFormatters: [
                      DateInputFormatter(),
                    ],
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: "Date fin",
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: "Choisissez une date",
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        )),
                  )),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
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
        cancel: Text(
          "Annuler",
          style: TextStyle(color: SECOND_COLOR),
          textScaleFactor: 1.3,
        ),
        confirm: Text(
          "Ok",
          style: TextStyle(color: FIRST_COLOR),
          textScaleFactor: 1.3,
        ),
      ),
      pickerMode: DateTimePickerMode.datetime,
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          if (param == "dateDebut") {
            _dateDebut = dateTime;
            _dateDebutControl.text = Methods.getStringFromDate(dateTime);
          } else {
            _dateFin = dateTime;
            _dateFinControl.text = Methods.getStringFromDate(dateTime);
          }
        });
        callBack();
      },
    );
  }

  void callBack() {
    widget.onChangeFilter({
      "dateDebut": _dateDebut,
      "dateFin": _dateFin,
      "depenseCheck": depenseCheck,
      "revenuCheck": revenuCheck,
    });
  }

}