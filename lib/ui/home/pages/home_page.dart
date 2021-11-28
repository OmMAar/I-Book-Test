import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_structure/common/widgets/base_body.dart';
import 'package:my_structure/common/widgets/vertical_padding.dart';
import 'package:my_structure/constants/app_constants.dart';
import 'package:my_structure/stores/language/language_store.dart';
import 'package:my_structure/stores/theme/theme_store.dart';
import 'package:my_structure/utils/device/device_utils.dart';
import 'package:my_structure/utils/routes/routes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  // //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;
  late TabController tabController;

  var _cancelToken = CancelToken();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    // _user = getIt<UserManagementDataSource>().getUserInfo();
  }

  @override
  void initState() {
    super.initState();

    tabController = new TabController(length: 3, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppBar appBar = AppBar(
      title: Text("Home"),
      backgroundColor: AppColors.appBarBGColor,
      brightness: Brightness.light,
      elevation: 0,
    );

    double widthC = DeviceUtils.getScaledWidth(context, 1);
    double heightC = DeviceUtils.getScaledHeight(context, 1) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.scaffoldBGColor,
      body: _buildBody(height: heightC, width: widthC),
    );
  }

  Widget _buildBody({required double width, required double height}) {
    return BaseBody(
      portraitWidget: _portraitWidget(
        height: height,
        width: width,
      ),
      landscapeWidget: _landscapeWidget(
        height: height,
        width: width,
      ),
      isSafeAreaTop: false,
    );
  }

  // portrait view:--------------------------------------------------------------
  Widget _portraitWidget({
    required double width,
    required double height,
  }) {
    return Container(
      height: height,
      width: width,
      child: Column(
        children: [
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.mapPage);
            },
            child: Container(
              width: 200,
              height: 50,
              child: Center(
                child: Text(
                  "To map",
                  style: appTextStyle.smallTSBasic
                      .copyWith(color: AppColors.mainColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // landscape view:--------------------------------------------------------------
  Widget _landscapeWidget({
    required double width,
    required double height,
  }) {
    return Container(
      height: height,
      width: width,
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimens.horizontal_padding),
      child: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 500),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                VerticalPadding(
                  percentage: 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
