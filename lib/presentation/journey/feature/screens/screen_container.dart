import 'package:flutter/material.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/presentation/journey/feature/auth/individual/individual_screen.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/bottom_nagivation_widget.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/layout_contain_widget_keep_alive.dart';
import 'Cart/cart_screen.dart';
import 'Category/category_screen.dart';
import 'Home/home_screen.dart';
import 'Notification/notification_screen.dart';



class ContainerScreen extends StatelessWidget {
  const ContainerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomNavigation(
        icons: const [
          IconConst.home,
          IconConst.category,
          IconConst.shopping_cart,
          IconConst.notifications,
          IconConst.user,
        ],
        tabViews: const [
          LayoutContainWidgetKeepAlive(child: HomeScreen()),
          LayoutContainWidgetKeepAlive(child: CategoriesScreen()),
          LayoutContainWidgetKeepAlive(child: CartScreen()),
          LayoutContainWidgetKeepAlive(child: NotificationScreen()),
          LayoutContainWidgetKeepAlive(child: IndividualScreen()),
        ],
      ),
    );
  }
}
