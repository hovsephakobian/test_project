import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_task/extentions/build_context_extention.dart';
import 'package:test_task/provider/warehouse_provider.dart';
import 'package:test_task/themes/app_colors.dart';
import 'package:test_task/utils/custom_app_bar.dart';

class StockView extends ConsumerStatefulWidget {
  @override
  _StockViewState createState() => _StockViewState();
}

class _StockViewState extends ConsumerState<StockView> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadMoreItems();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreItems();
      }
    });
  }

  void _loadMoreItems() {
    ref.read(wareHouseProvider.notifier).loadMore(50);
  }


  ///Много времени было потрачено  на данную функцию. Примерно 2 часа.
  void _handleKeyEvent(RawKeyEvent event) {
    var offset = _scrollController.offset;
    var viewportHeight = _scrollController.position.viewportDimension;
    var itemHeight = 56.0;

    int visibleItemCount = (viewportHeight / itemHeight)
        .floor();
    int firstVisibleIndex = (_scrollController.offset / itemHeight).floor();
    int lastVisibleIndex = firstVisibleIndex + visibleItemCount - 1;

    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        setState(() {
          if (_selectedIndex > 0) {
            _selectedIndex--;
            if (_selectedIndex < firstVisibleIndex) {
              _scrollController.animateTo(
                offset - itemHeight,
                duration: const Duration(milliseconds: 100),
                curve: Curves.ease,
              );
            }
          }
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        setState(() {
          if (_selectedIndex < ref.read(wareHouseProvider).length - 1) {
            _selectedIndex++;
            if (_selectedIndex > lastVisibleIndex) {
              _scrollController.animateTo(
                offset + itemHeight,
                duration: const Duration(milliseconds: 100),
                curve: Curves.ease,
              );
            }
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(wareHouseProvider);


    ///С пакетом DataTable2 была проблема, потратил больше часа
    return RawKeyboardListener(
      focusNode: focusNode,
      onKey: _handleKeyEvent,
      child: Scaffold(
        appBar: const CustomAppBar(appBarTitle: 'keywords.warehouseBalance'),
        body: DataTable2(
          dataRowHeight: 56.0,
          showCheckboxColumn: false,
          columns: [
            DataColumn(label: _columnTitle(title: 'keywords.productName')),
            DataColumn(label: _columnTitle(title: 'keywords.count')),
            DataColumn(label: _columnTitle(title: 'keywords.producer')),
          ],
          rows: List<DataRow>.generate(
            items.length,
            (index) {
              final item = items[index];
              return DataRow(
                cells: [
                  DataCell(_itemText(title: item.productName.toString())),
                  DataCell(_itemText(title: item.count.toString())),
                  DataCell(_itemText(title: item.producer.toString())),
                ],
                selected: _selectedIndex == index,
                onSelectChanged: (bool? selected) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              );
            },
          ),
          scrollController: _scrollController,
        ),
      ),
    );
  }

  ///Colum title
  AutoSizeText _columnTitle({required String title}) {
    return AutoSizeText(title.tr(),
        style: context.textTheme.bodyLarge
            ?.copyWith(color: AppColors.appBlack, fontWeight: FontWeight.w700));
  }

  ///Items text
  AutoSizeText _itemText({required String title}) {
    return AutoSizeText(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: context.textTheme.bodyLarge
          ?.copyWith(color: AppColors.appBarColor, fontWeight: FontWeight.w500),
    );
  }
}
