import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:section08/providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  const OrderItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  final ord.OrderItem order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _expanded
          ? min(widget.order.products!.length * 20.0 + 110, 200.0)
          : 95,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount}'),
              subtitle: Text(DateFormat('dd/MM/yyyy - hh:mm')
                  .format(widget.order.dateTime!)),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            // if (_expanded)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _expanded
                  ? min(widget.order.products!.length * 20.0 + 15, 100.0)
                  : 0,
              child: ListView.builder(
                itemCount: widget.order.products!.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.order.products![index].title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          '\$${widget.order.products![index].quantity} x \$${widget.order.products![index].price}'),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
