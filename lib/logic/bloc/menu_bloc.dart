import 'dart:async';

import 'package:nghe_phap/logic/viewmodels/menu_view_model.dart';
import 'package:nghe_phap/models/menu.dart';

class MenuBloc {
  final _menuVM = MenuViewModel();
  final menuController = StreamController<List<Menu>>();

  Stream<List<Menu>> get menuItems => menuController.stream;

  MenuBloc() {
    menuController.add(_menuVM.getMenuItems());
  }
}