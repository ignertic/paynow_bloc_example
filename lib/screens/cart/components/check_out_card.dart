import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_bloc/paynow_bloc.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:flutter/cupertino.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            BlocBuilder<PaynowBloc, PaynowState>(
              builder: (context, state){
                final checkoutButton = Column(
                  children : [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Total:\n",
                            children: [
                              TextSpan(
                                text: "${state.total}",
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(190),
                          child: DefaultButton(
                            text: "Check Out",
                            press: () {
                              // issue checkout event
                              BlocProvider.of<PaynowBloc>(context).add(PaynowCheckoutEvent(
                                paynowPaymentInfo: PaynowPaymentInfo(
                                  authEmail: "gishobertgwenzi@outlook.com", //replace with your paynow email here when testing
                                  reference: "paynow_bloc_example",
                                  paymentMethod: PaynowPaymentMethod.web,
                                )
                              ));
                            },
                          ),
                        ),
                      ],
                    ),

                  ]
                );

                if (state is PaynowInitialState){
                  return checkoutButton;
                }else if (state is PaynowLoadingState){
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircularProgressIndicator(),
                        Text("Payment In Progress")
                      ],
                    )
                  );
                }else if (state is PaynowPaymentSuccessfulState){
                  return ElevatedButton(
                    onPressed: (){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Your payment was successful"),
                        backgroundColor: Colors.green,
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.check_circle, color: Colors.white,),
                        Text("Payment Successful", style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900
                        ),)
                      ],
                    ),
                  );
                }else if (state is PaynowPaymentFailureState){
                  return Text("Payment Failed -> ${state.message}");
                }else{
                  return checkoutButton;
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}
