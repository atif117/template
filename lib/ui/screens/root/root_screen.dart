import 'package:antonx_flutter_template/core/constants/colors.dart';
import 'package:antonx_flutter_template/core/constants/strings.dart';
import 'package:antonx_flutter_template/ui/custom_widgets/bottom_nav_bar/fab_bar.dart';
import 'package:antonx_flutter_template/ui/custom_widgets/image_container.dart';
import 'package:antonx_flutter_template/ui/screens/root/root_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  //Todo: Do localizaiton here.
  @override
  Widget build(BuildContext context) {
    return Consumer<RootScreenViewModel>(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          final status = await Get.dialog(AlertDialog(
            title: Text('Caution!'),
            content: Text('Do you really want to close the application?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Get.back(result: true);
                },
                child: Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back(result: false);
                },
                child: Text('No'),
              ),
            ],
          ));

          /// In case user has choosen not to be kept logged in,
          /// he will get logged out of the app on exit.
          // if (status && !locator<AuthService>().isRemeberMe) {
          //   await locator<AuthService>().logout();
          // }
          return status;
        },
        child: Scaffold(
          extendBody: true,
          body: model.allScreen[model.selectedScreen],

          bottomNavigationBar: model.isEnableBottomBar
              ? FABBottomAppBar(
                  color: Colors.grey,
                  backgroundColor: Colors.grey,
                  selectedColor: primaryColor,
                  notchedShape: CircularNotchedRectangle(),
                  onTabSelected: model.updatedScreenIndex,
                  items: [
                    FABBottomAppBarItem(
                      icon: ImageContainer(
                        height: 30.h,
                        width: 30.h,
                        assets: "${staticAssetsPath}bottom_home_icon.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    FABBottomAppBarItem(
                      icon: ImageContainer(
                        height: 30.h,
                        width: 30.h,
                        assets: "${staticAssetsPath}bottom_card_icon.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    FABBottomAppBarItem(
                      icon: ImageContainer(
                        height: 30.h,
                        width: 30.h,
                        assets: "${staticAssetsPath}bottom_category_icon.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    FABBottomAppBarItem(
                      icon: ImageContainer(
                        height: 30.h,
                        width: 30.h,
                        assets: "${staticAssetsPath}bottom_profile_icon.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                )
              : Container(),
//      body: _list[_page],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: model.isEnableBottomBar
              ? FloatingActionButton(
                  backgroundColor: otherColor,
                  onPressed: () {},
                  child: Icon(Icons.add),
                  elevation: 2.0,
                )
              : Container(),
        ),
      ),
    );
  }
}
