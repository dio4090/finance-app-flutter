//Novo Billing Screen
import 'dart:developer';

import 'package:app_firebase/add_transaction/add_transaction_widget.dart';
import 'package:app_firebase/backend/backend.dart';
import 'package:app_firebase/entities/transaction_entity.dart';
import 'package:app_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:app_firebase/flutter_flow/flutter_flow_util.dart';
import 'package:app_firebase/flutter_flow/flutter_flow_widgets.dart';
import 'package:app_firebase/util/entities_util.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BillingScreenPastWidget());
}

class BillingScreenPastWidget extends StatefulWidget {
  const BillingScreenPastWidget({Key key}) : super(key: key);

  @override
  _BillingBcreeSWidgetState createState() => _BillingBcreeSWidgetState();
}

class _BillingBcreeSWidgetState extends State<BillingScreenPastWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final CollectionReference _transactions =
      FirebaseFirestore.instance.collection('transactions');

  EntitiesUtil _entitiesUtil = EntitiesUtil();
  TransactionEntity _transactionEnt = TransactionEntity();

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _UpdateTransaction(context,
      [DocumentSnapshot documentSnapshot]) async {
    if (documentSnapshot != null) {
      setState(() {
        _transactionEnt.documentId = documentSnapshot.id;
        _transactionEnt.createdAt = documentSnapshot['created_at'].toDate();
        _transactionEnt.description = documentSnapshot['description'];
        _transactionEnt.reason = documentSnapshot['reason'];
        _transactionEnt.value = documentSnapshot['value'];
        _entitiesUtil.isEditing = true;
        log(_transactionEnt.toString());
      });

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddTransactionWidget(),
        ),
      );

      //_nameController.text = documentSnapshot['name'];
      //_priceController.text = documentSnapshot['price'].toString();
    }
  }

  // Deleteing a product by id
  Future<void> _deleteTransaction(String transactionId) async {
    await _transactions.doc(transactionId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a transaction')));
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4E4EFF),
          title: const Text('Lista de transações do mês passado', textAlign: TextAlign.center),
        ),
        // Using StreamBuilder to display all products from Firestore in real-time
        body: Stack(
          children: [
            StreamBuilder(
              stream: _transactions.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0, 5.h, 0, 0),
                      child: Container(
                        width: 100.w,
                        height: 50.h,
                        child: ListView.builder(
                          itemCount: streamSnapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data.docs[index];
                            var date = DateTime.parse(
                                documentSnapshot['created_at']
                                    .toDate()
                                    .toString());
                            var createdAt =
                                DateFormat('dd/MM/yyyy').format(date);

                            return Padding(
                              //padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.w, 1.h, 20.w, 0),
                              child: Container(
                                width: 0.7.w,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color(0x35000000),
                                      offset: Offset(0, 1),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFF1F4F8),
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4, 4, 4, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 0, 0),
                                        child: Card(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          color: Color(0xFF4B39EF),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8, 8, 8, 8),
                                            child: Icon(
                                              Icons.money_off_csred_rounded,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                documentSnapshot['description'],
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .subtitle1
                                                    .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Color(0xFF090F13),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 4, 0, 0),
                                                child: Text(
                                                  'Gasto',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 12, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'R\$' +
                                                  documentSnapshot['value']
                                                      .toString(),
                                              textAlign: TextAlign.end,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .subtitle2
                                                  .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 4, 0, 0),
                                              child: Text(
                                                createdAt.toString(),
                                                textAlign: TextAlign.end,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Color(0xFF95A1AC),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //Botões ao final de cada Card
                                      SizedBox(
                                        width: 100,
                                        child: Row(
                                          children: [
                                            // Press this button to edit a single product
                                            IconButton(
                                                icon: const Icon(Icons.edit),
                                                onPressed: () async =>
                                                    _UpdateTransaction(context,
                                                        documentSnapshot)),
                                            // This icon button is used to delete a single product
                                            IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () =>
                                                    _deleteTransaction(
                                                        documentSnapshot.id)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ));
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.w, 25.h, 20.w, 0),
              child: Container(
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTransactionWidget(),
                        ),
                      );
                    },
                    text: 'Adicionar',
                    options: FFButtonOptions(
                      width: 160,
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
            ),
          ],
        ),
      );
    });
  }
}
