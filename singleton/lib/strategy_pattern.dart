// ye pattern tb use hota h jb humain 1 hi task k multiple types perform krny hain
// e.g. Payment Methods (Payment by Card, COD, Self Pickup)
// damage calculations in game (weapons, moves, spells, etc...)
// is design pattern se humary pas solid principles ka 'S' achieve hota h which means single responsibility
// https://miro.medium.com/v2/resize:fit:720/format:webp/1*964bv-8-GQeW5dk1iP7ZXw.png

import 'dart:math';

enum PackageSize { S, M, L, XL }

class OrderItems {
  late String? title;
  late double? price;
  late PackageSize? packageSize;

  OrderItems({this.title, this.price, this.packageSize});

  OrderItems.random() {
    var packageSizeList = PackageSize.values;
    title = "Any name";
    var rng = Random();

    price = rng.nextInt(100) - 0.01;
    packageSize = packageSizeList[rng.nextInt(packageSizeList.length)];
  }
}

class Order {
  final List<OrderItems> items = [];

  double get price => items.fold(0, (sum, orderItem) => sum + orderItem.price!);

  void addOrderItem(OrderItems orderItems) {
    items.add(orderItems);
  }
}

class InStorePickupStrategy extends IShippingCostStrategy {
  @override
  String label = "In Shop Strategy";

  @override
  double calculate(Order order) {
    return 0.0;
  }
}

class PriorityShippingStrategy extends IShippingCostStrategy {
  @override
  String label = "Priority Shipping Strategy";

  @override
  double calculate(Order order) {
    return 9.99;
  }
}

class ParcelTerminalShippingStrategy extends IShippingCostStrategy {
  @override
  String label = "In Parcel Terminal Shipping Strategy";

  @override
  double calculate(Order order) {
    return order.items
        .fold<double>(0.0, (sum, item) => _getOrderItemShippingPrice(item));
  }

  _getOrderItemShippingPrice(OrderItems orderItems) {
    switch (orderItems.packageSize) {
      case PackageSize.S:
        return 1.99;

      case PackageSize.M:
        return 2.99;

      case PackageSize.L:
        return 3.99;

      case PackageSize.XL:
        return 4.99;

      default:
        throw new Exception(
            "Unknown shipping price of shipping size ${orderItems.packageSize}");
    }
  }
}

abstract class IShippingCostStrategy {
  late String label;
  double calculate(Order order);
}

class StrategyExample {
  final List<IShippingCostStrategy> _shippingCostStrategyList = [
    InStorePickupStrategy(),
    PriorityShippingStrategy(),
    ParcelTerminalShippingStrategy()
  ];
}

void main(List<String> args) {}
