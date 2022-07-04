// main.dart
import 'dart:developer';

import 'package:app_firebase/billing_screen/billing_screen_widget.dart';
import 'package:app_firebase/entities/transaction_entity.dart';
import 'package:app_firebase/util/entities_util.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AddTransactionWidget());
}

class AddTransactionWidget extends StatelessWidget {
  const AddTransactionWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: AddTransaction(),
    );
  }
}

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  // text fields' controllers
  TextEditingController valueTextController;
  DateTimeRange calendarSelectedDay;
  TextEditingController spentAtController;
  String transactionType;
  TextEditingController reasonController;

  EntitiesUtil _entitiesUtil = EntitiesUtil();
  TransactionEntity _transactionEnt = TransactionEntity();

  final CollectionReference _transactions =
      FirebaseFirestore.instance.collection('transactions');

  @override
  void initState() {
    super.initState();

    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    valueTextController = TextEditingController();
    spentAtController = TextEditingController();
    reasonController = TextEditingController();

    checkUpdateState();
  }

  void checkUpdateState() {
    if (_entitiesUtil.isEditing) {
      log('Vindo de outra tela: ' + _transactionEnt.documentId);
      calendarSelectedDay = DateTimeRange(
          start: _transactionEnt.createdAt.startOfDay,
          end: _transactionEnt.createdAt.endOfDay);
      valueTextController.text = _transactionEnt.value.toString();
      spentAtController.text = _transactionEnt.description;
      reasonController.text = _transactionEnt.reason;
    }
  }

  //TODO: Fazer a opção inicial do menu funcionar
  String getDropDownOptionMenuIfExists() {
    if (_entitiesUtil.isEditing) {
      return _transactionEnt.type;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF4E4EFF),
            //title: const Text(''),
            ),
        body: Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              // prevent the soft keyboard from covering text fields
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Adicionar transação',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).title2.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF14181B),
                            fontSize: 40,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        buttonSize: 60,
                        fillColor: Colors.black,
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BillingScreenWidget(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // Generated code for this Calendar Widget...
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  //padding: EdgeInsetsDirectional.fromSTEB(700, 0, 700, 0),
                  padding: EdgeInsetsDirectional.fromSTEB(40.w, 2.5.h, 40.w, 0),
                  child: FlutterFlowCalendar(
                    color: FlutterFlowTheme.of(context).primaryColor,
                    weekFormat: false,
                    weekStartsMonday: false,
                    rowHeight: 45,
                    onChange: (DateTimeRange newSelectedDate) {
                      setState(() => calendarSelectedDay = newSelectedDate);
                    },
                    titleStyle: TextStyle(),
                    dayOfWeekStyle: TextStyle(),
                    dateStyle: TextStyle(),
                    selectedDateStyle: TextStyle(),
                    inactiveDateStyle: TextStyle(),
                  ),
                ),
              ),
              // Generated code for this priceTextField Widget...
              Padding(
                  //padding: EdgeInsetsDirectional.fromSTEB(700, 16, 700, 2),
                  padding: EdgeInsetsDirectional.fromSTEB(43.w, 2.5.h, 43.w, 0),
                  child: TextFormField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: valueTextController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelStyle: FlutterFlowTheme.of(context).title1.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF57636C),
                            fontSize: 34,
                            fontWeight: FontWeight.w300,
                          ),
                      hintText: 'Total',
                      hintStyle: FlutterFlowTheme.of(context).title1.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF57636C),
                            fontSize: 34,
                            fontWeight: FontWeight.w300,
                          ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF1F4F8),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF1F4F8),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(20, 24, 24, 24),
                      prefixIcon: FaIcon(
                        FontAwesomeIcons.coins,
                        color: Color(0xFF57636C),
                        size: 32,
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).title1.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF14181B),
                          fontSize: 34,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  )),
              // Generated code for this SpentAt Widget...
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(35.w, 2.5.h, 35.w, 0),
                  child: TextFormField(
                    controller: spentAtController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Gasto em',
                      labelStyle:
                          FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF14181B),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF1F4F8),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF1F4F8),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(20, 24, 24, 24),
                    ),
                    style: FlutterFlowTheme.of(context).bodyText2.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF57636C),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                  )),
              // Generated code for this budget Widget...
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(35.w, 2.5.h, 35.w, 0),
                child: FlutterFlowDropDown(
                  //initialOption: getDropDownOptionMenuIfExists(),
                  options: [
                    'Pix',
                    'Cartão de crédito',
                    'Cartão de débito',
                    'Transferência Bancária'
                  ],
                  onChanged: (val) => setState(() => transactionType = val),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,
                  textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF14181B),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                  hintText: 'Tipo de transferência',
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFF57636C),
                    size: 15,
                  ),
                  fillColor: Colors.white,
                  elevation: 2,
                  borderColor: Color(0xFFF1F4F8),
                  borderWidth: 2,
                  borderRadius: 8,
                  margin: EdgeInsetsDirectional.fromSTEB(20, 20, 12, 20),
                  hidesUnderline: true,
                ),
              ),
              // Generated code for this reason Widget...
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(35.w, 2.5.h, 35.w, 0),
                  child: TextFormField(
                    controller: reasonController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Motivo',
                      labelStyle:
                          FlutterFlowTheme.of(context).bodyText2.override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                      hintText: 'Digite o motivo aqui...',
                      hintStyle:
                          FlutterFlowTheme.of(context).bodyText2.override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF1F4F8),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF1F4F8),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(20, 40, 24, 0),
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF14181B),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                    textAlign: TextAlign.start,
                    maxLines: 4,
                  )),
              // Generated code for this Button Widget...
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      final DateTime createdAt = calendarSelectedDay.end;
                      final description = spentAtController.text;
                      final reason = reasonController.text;
                      final type = transactionType;
                      final double value =
                          double.tryParse(valueTextController.text);

                      if (description != null &&
                          reason != null &&
                          type != null &&
                          value != null) {
                        if (_entitiesUtil.isEditing) {
                          await _transactions
                              .doc(_transactionEnt.documentId)
                              .update({
                            "created_at": createdAt,
                            "description": description,
                            'reason': reason,
                            'type': type,
                            'value': value
                          });
                          _transactionEnt.cleanEntity();
                          _entitiesUtil.isEditing = false;
                        } else {
                          await _transactions.add({
                            "created_at": createdAt,
                            "description": description,
                            'reason': reason,
                            'type': type,
                            'value': value
                          });
                        }

                        // Clear the text fields
                        spentAtController.text = '';
                        reasonController.text = '';
                        transactionType = '';
                        valueTextController.text = '';

                        // Hide the bottom sheet
                        //Navigator.of(context).pop();
                      }
                    },
                    text: 'Cadastrar',
                    options: FFButtonOptions(
                      width: 150,
                      height: 60,
                      color: FlutterFlowTheme.of(context).primaryColor,
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
