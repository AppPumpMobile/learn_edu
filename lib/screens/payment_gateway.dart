import 'dart:io';
import 'dart:convert';
import 'dart:math';

import 'package:eclass/gateways/cashfree_payment.dart';
import 'package:eclass/gateways/instamojo_payment.dart';
import 'package:eclass/gateways/manual_payment_list.dart';
import 'package:pay/pay.dart';
import 'package:eclass/gateways/paypal/PaypalPayment.dart';
import 'package:eclass/gateways/rave_payment.dart';
import 'package:eclass/gateways/stripe_payment.dart';
import 'package:eclass/gateways/upi_payment.dart';
import 'package:eclass/model/payment_gateway_model.dart';
import 'package:eclass/provider/manual_payment_provider.dart';
import 'package:eclass/provider/user_profile.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../Widgets/success_ticket.dart';
import '../Widgets/utils.dart';
import '../common/apidata.dart';
import '../common/global.dart';
import '../gateways/bank_payment.dart';
import '../gateways/paystack_payment.dart';
import '../gateways/paytm_payment_page1.dart';
import '../gateways/razor_payments.dart';
import '../provider/home_data_provider.dart';
import '../provider/payment_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../common/theme.dart' as T;
import 'bottom_navigation_screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PaymentGateway extends StatefulWidget {
  final int tAmount;
  final disCountedAmount;

  PaymentGateway(this.tAmount, this.disCountedAmount);

  @override
  _PaymentGatewayState createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  int value;
  int id;
  var payAbleAmount;
  List<PaymentGatewayModel> listPayment = [];
  var loading = true;
  bool isLoading = false;
  var rng = Random();
  Widget bottomFixed(payment, user) {
    var homeData = Provider.of<HomeDataProvider>(context);
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Color(0x1c2464).withOpacity(0.30),
            blurRadius: 15.0,
            offset: Offset(0.0, -20.5),
            spreadRadius: -15.0)
      ]),
      child: InkWell(
        child: Material(
          color: Colors.transparent,
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(18.0),
              padding: EdgeInsets.all(10.0),
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Color(0xFFF44A4A),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF6E1A52),
                      Color(0xFFF44A4A),
                    ]),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${translate("Amount_")}:  ${payAbleAmount.toString()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  Text(
                    "${translate("Continue_to_payment")} >>",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                ],
              )),
        ),
        onTap: () {
          if (id == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    StripePaymentScreen(amount: payAbleAmount),
              ),
            );
          } else if (id == 2) {
            onPayWithPayPal(homeData, user);
          }
          // else if (id == 3) {
          //   if ("${homeData.homeModel.currency.currency}" == "NGN" ||
          //       "${homeData.homeModel.currency.currency}" == "GHS" ||
          //       "${homeData.homeModel.currency.currency}" == "USD" ||
          //       "${homeData.homeModel.currency.currency}" == "ZAR") {
          //     Navigator.push(
          //       context,
          //       PageTransition(
          //         type: PageTransitionType.rightToLeft,
          //         child: PayStackPage(
          //           amount: payAbleAmount,
          //           currency: "${homeData.homeModel.currency.currency}",
          //         ),
          //       ),
          //     );
          //   } else {
          //     Fluttertoast.showToast(
          //         msg: translate("Supports_only_NGN_GHS_USD_&_ZAR_currency"));
          //   }
          // }
          else if (id == 4) {
            Fluttertoast.showToast(msg: translate("Supported_only_live_mode"));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaytmPaymentPage(
                  amount: payAbleAmount,
                ),
              ),
            );
          } else if (id == 5) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => MyRazorPaymentPage(
            //       amount: payAbleAmount,
            //     ),
            //   ),
            // );
          }
          //else if (id == 6) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => InstamojoPaymentPage(
            //       amount: payAbleAmount,
            //     ),
            //   ),
            // );
          //}
          else if (id == 7) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => PayHerePayment(
            //       amount: payAbleAmount,
            //     ),
            //   ),
            // );
          }
          // else if (id == 71) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => RavePayment(
          //         amount: payAbleAmount,
          //       ),
          //     ),
          //   );
          // }
          else if (id == 72) {
          } else if (id == 73) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CashfreePayment(
                  amount: payAbleAmount,
                ),
              ),
            );
          } else if (id == 74) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UPIPayment(
                  amount: payAbleAmount,
                ),
              ),
            );
          } else if (id == 8) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BankPayment(),
              ),
            );
          } else if (id == 9) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManualPaymentList(
                  manualPaymentModel: manualPaymentProvider.manualPaymentModel,
                ),
              ),
            );
          } else {
            Fluttertoast.showToast(
                msg: translate("Please_select_payment_gateway"));
          }
        },
      ),
    );
  }

  void onPayWithPayPal(homeData, user) {
    var currency = homeData.homeModel.currency.currency;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalPayment(
          onFinish: (number) async {},
          currency: currency,
          userFirstName: user.profileInstance.fname,
          userLastName: user.profileInstance.lname,
          userEmail: user.profileInstance.email,
          payAmount: "$payAbleAmount",
        ),
      ),
    );
  }

  ManualPaymentProvider manualPaymentProvider = ManualPaymentProvider();

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    payAbleAmount = widget.disCountedAmount;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      PaymentAPIProvider paymentAPIProvider =
          Provider.of<PaymentAPIProvider>(context, listen: false);
      await paymentAPIProvider.fetchPaymentAPI(context);

      manualPaymentProvider =
          Provider.of<ManualPaymentProvider>(context, listen: false);
      await manualPaymentProvider.fetchData();

      var manualPayment =
          manualPaymentProvider.manualPaymentModel.manualPayment.isNotEmpty
              ? "1"
              : "0";

      var stripe = Provider.of<HomeDataProvider>(context, listen: false)
          .homeModel
          .settings
          .stripeEnable;
      var paypal = Provider.of<HomeDataProvider>(context, listen: false)
          .homeModel
          .settings
          .paypalEnable;
      var paystack = Provider.of<HomeDataProvider>(context, listen: false)
          .homeModel
          .settings
          .paystackEnable;
      var paytm = Provider.of<HomeDataProvider>(context, listen: false)
          .homeModel
          .settings
          .paytmEnable;
      var razorpay = Provider.of<HomeDataProvider>(context, listen: false)
          .homeModel
          .settings
          .razorpayEnable;
      var instamojo = Provider.of<HomeDataProvider>(context, listen: false)
          .homeModel
          .settings
          .instamojoEnable;
      var payhere = Provider.of<HomeDataProvider>(context, listen: false)
          .homeModel
          .settings
          .enablePayhere;
      var rave = Provider.of<HomeDataProvider>(context, listen: false)
          .homeModel
          .settings
          .enableRave;
      var payu = Provider.of<HomeDataProvider>(context, listen: false)
          .homeModel
          .settings
          .enablePayu;
      var cashfree = Provider.of<HomeDataProvider>(context, listen: false)
          .homeModel
          .settings
          .enableCashfree;
      var bank = Provider.of<PaymentAPIProvider>(context, listen: false)
                  .paymentApi
                  .bankDetails ==
              null
          ? 0
          : Provider.of<PaymentAPIProvider>(context, listen: false)
              .paymentApi
              .bankDetails
              .bankEnable;

      if (stripe == 1 || stripe == "1") {
        listPayment.add(
          PaymentGatewayModel(
              1, "Stripe", "assets/placeholder/stripe.png", "1"),
        );
      }
      if (paypal == 1 || paypal == "1") {
        listPayment.add(
          PaymentGatewayModel(
              2, "Paypal", "assets/placeholder/paypal.png", "1"),
        );
      }
      if (paystack == 1 || paystack == "1") {
        listPayment.add(PaymentGatewayModel(
            3, "PayStack", "assets/placeholder/paystackwallets.png", "1"));
      }
      if (paytm == 1 || paytm == "1") {
        listPayment.add(
          PaymentGatewayModel(4, "Paytm", "assets/placeholder/paytm.png", "1"),
        );
      }
      if (razorpay == 1 || razorpay == "1") {
        listPayment.add(
          PaymentGatewayModel(
              5, "RazorPay", "assets/placeholder/razorpay.png", "1"),
        );
      }
      if (instamojo == 1 || instamojo == "1") {
        listPayment.add(
          PaymentGatewayModel(
              6, "Instamojo", "assets/placeholder/instamojo.png", "1"),
        );
      }
      if (payhere == 1 || payhere == "1") {
        listPayment.add(
          PaymentGatewayModel(
              7, "PayHere", "assets/placeholder/payhere.png", "1"),
        );
      }
      if (rave == 1 || rave == "1") {
        listPayment.add(
          PaymentGatewayModel(71, "Rave", "assets/placeholder/rave.png", "1"),
        );
      }
      if (payu == 1 || payu == "1" || false) {
        listPayment.add(
          PaymentGatewayModel(
              72, "PayU", "assets/placeholder/payumoney.png", "1"),
        );
      }
      if (cashfree == 1 || cashfree == "1") {
        listPayment.add(
          PaymentGatewayModel(
              73, "Cashfree", "assets/placeholder/cashfree.png", "1"),
        );
      }
      if (bank == 1 || bank == "1") {
        listPayment.add(
          PaymentGatewayModel(
              8, "Bank Transfer", "assets/placeholder/bankwallets.png", "1"),
        );
      }
      if (manualPayment == 1 || manualPayment == "1") {
        listPayment.add(
          PaymentGatewayModel(
              9, "Manual Payment", "assets/placeholder/manualpayment.png", "1"),
        );
      }
      setState(() {
        loading = false;
      });
    });
  }

  Widget listsOfGateways() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          height: 90,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              top: index == 0
                  ? BorderSide(width: 1, color: Colors.grey.withOpacity(0.4))
                  : BorderSide.none,
              bottom: BorderSide(
                width: 1,
                color: Colors.grey.withOpacity(0.4),
              ),
            ),
          ),
          child: RadioListTile(
            activeColor: const Color(0xFF0284A2),
            value: index,
            groupValue: value,
            onChanged: (ind) {
              setState(() {
                value = ind;
                id = listPayment[index].id;
              });
            },
            title: Row(
              children: [
                Container(
                  height: 65,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(listPayment[index].walletImage),
                      ),
                      borderRadius: BorderRadius.circular(15)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    listPayment[index].name,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: listPayment.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    T.Theme mode = Provider.of<T.Theme>(context);
    var payment = Provider.of<PaymentAPIProvider>(context).paymentApi;
    var user = Provider.of<UserProfile>(context);
    return Scaffold(
      appBar: secondaryAppBar(
          Colors.black, mode.bgcolor, context, translate("Checkout")),
      backgroundColor: mode.bgcolor,
      bottomNavigationBar:
          value == null ? SizedBox.shrink() : bottomFixed(payment, user),
      body:
          //Center(child: listsOfGateways())
          Center(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GooglePayButton(
                paymentConfigurationAsset:
                    'default_payment_profile_google_pay.json',
                paymentItems: [
                  PaymentItem(
                    amount: widget.tAmount.toString(),
                    label: 'Total',
                    status: PaymentItemStatus.final_price,
                  )
                ],
                type: GooglePayButtonType.pay,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: (Map<String, dynamic> val) {
                  _sendPaymentToServer(
                      '${rng.nextInt(600000) + rng.nextInt(100000) + rng.nextInt(8000)}',
                      'Google Pay');
                },
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),

      //   listsOfGateways(),
    );
  }

  // var _paymentItems = [
  //   PaymentItem(
  //     label: 'Total',
  //     amount: '1.0',
  //     status: PaymentItemStatus.final_price,
  //   )
  // ];
  // void onGooglePayResult(paymentResult) {
  //   debugPrint(paymentResult.toString());
  //   var rng = Random();
  //   _sendPaymentToServer(
  //       paymentResult['tokenizationData']['info']['cardDetails'] +
  //           'fffffffffffff',
  //       'GooglePay');
  //   //  goToDialog(DateTime.now(), DateTime.now());
  // }

  goToDialog(subdate, time, msgRes) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => new GestureDetector(
              child: Container(
                color: Colors.white.withOpacity(0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SuccessTicket(
                      msgResponse: "$msgRes",
                      purchaseDate: subdate,
                      time: time,
                      transactionAmount: widget.tAmount.toString(),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyBottomNavigationBar(
                                      pageInd: 0,
                                    )));
                      },
                    )
                  ],
                ),
              ),
            ));
  }

  _sendPaymentToServer(transactionId, paymentMethod) async {
    print('IAM WORKING');
    setState(() {
      isLoading = true;
    });
    try {
      var sendResponse;

      sendResponse = await http.post(
        Uri.parse("${APIData.payStore}${APIData.secretKey}"),
        body: {
          "transaction_id": "$transactionId",
          "payment_method": "$paymentMethod",
          "pay_status": "1",
          "sale_id": "null",
        },
        headers: {HttpHeaders.authorizationHeader: "Bearer $authToken"},
      );
      print('CCCCCCCCC${sendResponse}');
      if (sendResponse.statusCode == 200) {
        var date = DateTime.now();
        var time = DateTime.now();
        var createdDate = DateFormat('d MMM y').format(date);
        var createdTime = DateFormat('HH:mm a').format(time);
        var res = json.decode(sendResponse.body);
        print("Res3: ${sendResponse.body}");
        var msgRes;
        setState(() {
          isLoading = false;
          msgRes = res;
        });

        goToDialog(createdDate, createdTime, msgRes);
      } else {
        setState(() {
          isLoading = false;
        });

        Fluttertoast.showToast(msg: "Your transaction failed.");
      }
    } catch (error) {
      print(error);
    }
  }
}
