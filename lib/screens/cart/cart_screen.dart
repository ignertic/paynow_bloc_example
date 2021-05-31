import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_bloc/paynow_bloc.dart';
import 'package:shop_app/models/Cart.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BlocListener<PaynowBloc, PaynowState>(
        listener: (context, state){
          if (state is PaynowInitialState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Tap Checkout to begin transaction"),
              backgroundColor: Colors.blue,
            ));
          }else if (state is PaynowPaymentSuccessfulState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Great! Payment Succefful"),
              backgroundColor: Colors.green,
            ));
          }else if (state is PaynowPaymentFailureState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Something went wrong ${state.message}."),
              backgroundColor: Colors.red,
            ));
          }else if (state is PaynowLoadingState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Processing payment............"),
              backgroundColor: Colors.blueGrey,
            ));
          }
        } ,
        child: Body(),
      ),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${demoCarts.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
