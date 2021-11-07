import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_structure/blocs/user/get_user_list_bloc.dart';
import 'package:my_structure/models/user/user_model.dart';
import 'package:my_structure/ui/home/widgets/item_user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:my_structure/constants/app_constants.dart';
import 'package:my_structure/utils/device/app_uitls.dart';
import 'package:my_structure/utils/locale/app_localization.dart';
import 'package:my_structure/widgets/my_classic_footer.dart';

class UserGridViewWithFilterPaginationWidget extends StatefulWidget {
  final CancelToken cancelToken;
  final double width;

  const UserGridViewWithFilterPaginationWidget({
    required this.cancelToken,
    required this.width,
  });

  @override
  _UserGridViewWithFilterPaginationWidgetState createState() =>
      _UserGridViewWithFilterPaginationWidgetState();
}

class _UserGridViewWithFilterPaginationWidgetState
    extends State<UserGridViewWithFilterPaginationWidget> {
  var _bloc = GetUserListBloc();
  GlobalKey _key = GlobalKey();
  final _refresherController = RefreshController();

  List<UserModel> moms = [];
  @override
  void initState() {
    super.initState();
    _bloc.add(GetUserListEvent(
        cancelToken: widget.cancelToken,
        loadMore: false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetUserListBloc, GetUserListState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is GetUserListSuccess) {
            moms = state.users;
            _refresherController.loadComplete();
            _refresherController.refreshCompleted();

            print("bloc is here empty page");
            if (state.noMoreData) {
              print("bloc is here empty one noMoreData");
              AppUtils.showMessage(
                  message: AppLocalizations.of(context)
                      .translate('there_are_no_more_data'),
                  context: context,
                  title: "");
            }
          }
          if (state is GetUserListEmpty) {

            _refresherController.loadComplete();
            _refresherController.refreshCompleted();
            AppUtils.showMessage(
                message: AppLocalizations.of(context)
                    .translate('there_are_no_more_data'),
                context: context,
                title: "");
          }
          if (state is GetUserListFailure) {
            _refresherController.loadComplete();
            _refresherController.refreshCompleted();
            AppUtils.showErrorMessage(error: state.error, context: context);
          }
        },
        child: BlocBuilder<GetUserListBloc, GetUserListState>(
            bloc: _bloc,
            builder: (context, state) {
              return SmartRefresher(
                controller: _refresherController,
                enablePullUp: true,
                onRefresh: () {
                  _update();
                  _bloc.add(GetUserListEvent(
                      cancelToken: widget.cancelToken,
                      loadMore: false));
                },
                onLoading: _onLoading,
                header: MaterialClassicHeader(
                  color: AppColors.mainColor,
                ),
                footer: MyClassicFooter(),
                child: _viewWidget(result: moms, state: state),
              );
            }));
  }

  Widget _viewWidget(
      {required List<UserModel> result,
      required GetUserListState state}) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        var metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          if (metrics.pixels == 0)
            print('At top');
          else {
            _onLoading();
            print('At bottom');
          }
        }
        return true;
      },
      child: _buildListItem(result: result, state: state),
    );
  }

  _buildListItem(
      {required List<UserModel> result,
      required GetUserListState state}) {
    return result.isNotEmpty
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.space20),
            child: GridView.builder(
              itemCount: result.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: AppDimens.space8,
                mainAxisSpacing: AppDimens.space8,
                childAspectRatio: 80 / 100,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ItemUser(user: moms[index]);
              },
            ))
        : state is GetUserListLoading
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppDimens.space20),
                child:Center(child: SpinKitRing(color: AppColors.mainColor,),))
            : state is GetUserListEmpty
                ? Container(
                    child: Center(
                        child: Text(
                            AppLocalizations.of(context).translate('no_data'))),
                  )
                : Container();
  }

  /// ====================== functions Section ======================================
  void _onLoading() {
    _bloc.add(GetUserListEvent(
        cancelToken: widget.cancelToken,
        loadMore: true));
  }

  _update() {
    if (mounted) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _bloc = GetUserListBloc();
        _key = GlobalKey();
        moms = [];
        _bloc.add(GetUserListEvent(
            cancelToken: widget.cancelToken,
            loadMore: false));
        setState(() {});
      });
    }
  }
}
