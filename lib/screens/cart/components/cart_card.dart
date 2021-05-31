import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_bloc/paynow_bloc.dart';
import 'package:shop_app/models/Cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(cart.product.images[0]),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.title,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            BlocBuilder<PaynowBloc, PaynowState>(
              builder: (context, state){
                return Text.rich(
                  TextSpan(
                    text: "\$${cart.product.price}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                    children: [
                      TextSpan(
                          text: " x${state.cartItems[cart.product]??0}",
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text("Add To Cart"),
              onPressed:(){
                // add to card
                BlocProvider.of<PaynowBloc>(context).add(AddItemToCartEvent(cart.product));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Added ${cart.product.title} to cart"),
                ));
              } ,
            ),
            ElevatedButton(
              child: Text("Remove"),
              onPressed:(){
                // remove from cart
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Removed ${cart.product.title}"),
                ));
                BlocProvider.of<PaynowBloc>(context).add(RemoveItemFromCartEvent(cart.product));
              },
            )
          ],
        )
      ],
    );
  }
}
