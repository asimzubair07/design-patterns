import 'package:flutter/material.dart';
import 'package:strategy_pattern/strategy_pattern.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strategy Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StrategyExample(),
    );
  }
}

class StrategyExample extends StatefulWidget {
  const StrategyExample();

  @override
  State<StrategyExample> createState() => _StrategyExampleState();
}

class _StrategyExampleState extends State<StrategyExample> {
  final List<IShippingCostStrategy> _shippingCostStrategyList = [
    ParcelTerminalShippingStrategy(),
    InStorePickupStrategy(),
    PriorityShippingStrategy()
  ];
  int selectedStrategyIndex = 0;
  var order = Order();
  void _addToOrders() =>
      setState(() => order.addOrderItem(OrderItems.random()));
  void _clearOrders() => setState(() => order = Order());
  void setselectedStrategyIndex(int? index) {
    setState(() => selectedStrategyIndex = index!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: _addToOrders, child: const Text("Add")),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: _clearOrders, child: const Text("Clear")),
                ],
              ),
              Shippingoptions(
                  shippingoptions: _shippingCostStrategyList,
                  selectedIndex: selectedStrategyIndex,
                  onChanged: setselectedStrategyIndex),
              OrderSummary(
                  order, _shippingCostStrategyList[selectedStrategyIndex])
            ],
          ),
        ),
      ),
    );
  }
}

class Shippingoptions extends StatelessWidget {
  final List<IShippingCostStrategy> shippingoptions;
  final int selectedIndex;
  final Function(int?) onChanged;
  const Shippingoptions({
    required this.shippingoptions,
    required this.selectedIndex,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select shipping type:",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                for (var i = 0; i < shippingoptions.length; i++)
                  RadioListTile<int>(
                    title: Text(shippingoptions[i].label),
                    value: i,
                    groupValue: selectedIndex,
                    onChanged: onChanged,
                    dense: true,
                    activeColor: Colors.black,
                    controlAffinity: ListTileControlAffinity.platform,
                  ),
              ],
            )));
  }
}

class OrderSummary extends StatelessWidget {
  final Order order;
  final IShippingCostStrategy shippingCostStrategy;
  const OrderSummary(this.order, this.shippingCostStrategy);
  double get shippingPrice => shippingCostStrategy.calculate(order);
  double get total => order.price + shippingPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Order summary',
                style: Theme.of(context).textTheme.headline6,
              ),
              const Divider(),
              Text("Price ${order.price}"),
              Text("Shipping Price ${shippingPrice.toString()}"),
              Text("Order Total ${total.toString()}")
            ])));
  }
}
