import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'drop_select_controller.dart';
import 'drop_select_object.dart';
import 'drop_select_widget.dart';

const double kDropExpendedSelectMenuItemHeight = 45.0;

typedef Widget MenuItemGridBuilder<T extends DropSelectObject>(
    BuildContext context, T data);

class DropSelectGridListMenu<T extends DropSelectObject>
    extends DropSelectWidget {
  final List<T> data;
  final double itemExtent;
  final MenuItemGridBuilder itemBuilder;

  DropSelectGridListMenu(
      {this.data,
      this.itemBuilder,
      this.itemExtent: kDropExpendedSelectMenuItemHeight});

  @override
  DropSelectState<DropSelectWidget> createState() {
    return new _MenuListGridState<T>();
  }
}

class _MenuListGridState<T extends DropSelectObject>
    extends DropSelectState<DropSelectGridListMenu<T>> {
  @override
  void initState() {
    super.initState();
  }

  renderGrid(count, data, index) {
    return new Container(
      height: widget.itemExtent * count,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: List.generate(count, (index) {
          return widget.itemBuilder(context, data.children[index]);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        itemBuilder: (context, index) {
          return new Container(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new Text(widget.data[index].title),
                  alignment: Alignment.centerLeft,
                ),
                renderGrid(widget.data[index].children.length,
                    widget.data[index], index)
              ],
            ),
          );
        },
        itemCount: widget.data.length,
      ),
    );
  }

  @override
  void onEvent(DropSelectEvent event) {
    switch (event) {
      case DropSelectEvent.SELECT:
      case DropSelectEvent.HIDE:
        {}
        break;
      case DropSelectEvent.ACTIVE:
        {}
        break;
    }
  }
}
