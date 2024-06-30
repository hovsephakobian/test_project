import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_task/models/warehouse_item_model.dart';
import 'package:test_task/provider/service.dart';



final wareHouseProvider = StateNotifierProvider<WarehouseStateNotifier, List<WarehouseItemsModel>>((ref) {
  return WarehouseStateNotifier();
});

class WarehouseStateNotifier extends StateNotifier<List<WarehouseItemsModel>> {
  WarehouseStateNotifier() : super([]);

  void loadMore(int count) {
    final newItems = generateStockItems(count);
    state += newItems;
  }
}
