import 'dart:math';

import 'package:test_task/models/warehouse_item_model.dart';


///Потратил больше часа минут на эту функцию
String generateRandomString(int minLength, int maxLength) {
  const chars = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";
  final rand = Random();
  final length = minLength + rand.nextInt(maxLength - minLength + 1);
  return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rand.nextInt(chars.length))));
}

List<WarehouseItemsModel> generateStockItems(int count) {
  final rand = Random();
  return List.generate(count, (index) {
    return WarehouseItemsModel(
      productName: generateRandomString(50, 100),
      producer: generateRandomString(20, 50),
      count: rand.nextInt(100),
    );
  });
}