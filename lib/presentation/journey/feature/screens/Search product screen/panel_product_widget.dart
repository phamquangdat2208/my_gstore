import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/customs/custom_circular_indicator.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../../injector_container.dart';
import 'Map Search Screen/gridview_product_map_search_screen.dart';
import 'cubit/map_search_screen_cubit.dart';

class ProductPanel extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;

  ProductPanel(
      {Key? key, required this.controller, required this.panelController})
      : super(key: key);

  @override
  State<ProductPanel> createState() => _ProductPanelState();
}

class _ProductPanelState extends State<ProductPanel> {
  MapSearchProductScreenCubit _mapsearchCubit = injector<MapSearchProductScreenCubit>();
  bool _enableContinueLoadMore = true;
  @override
  void initState() {
    _mapsearchCubit.getDataLoadInMap();
    widget.controller.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
  if(widget.panelController.isPanelOpen){
    if (widget.controller.position.extentAfter < 100) {
      if (_enableContinueLoadMore) {
        _enableContinueLoadMore = false;
        _mapsearchCubit.getMoreLoadData();
      }
    }
  }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: _BuildGridView());
  }

  void toggleClose() {
    widget.panelController.isPanelClosed
        ? widget.panelController.open()
        : widget.panelController.close();
  }

  void toggleOpen() {
    widget.panelController.isPanelOpen
        ? widget.panelController.close()
        : widget.panelController.open();
  }

  Widget _BuildGridView() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: toggleClose,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      size: 25,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: GestureDetector(
                    onTap: toggleOpen,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        size: 35,
                      ),
                    )),
              ),
              Spacer(),
            ],
          ),
        ),
        BlocBuilder<MapSearchProductScreenCubit, MapSearchScreenState>(
            bloc: _mapsearchCubit,
            buildWhen: (_,state){
              return state is MapSearchScreenGettingDataState ||
              state is MapSearchScreenGotDataState;
            },
            builder: (_, state) {
              if (state is MapSearchScreenGettingDataState) {
                return CustomCircularIndicator();
              }
              if (state is MapSearchScreenGotDataState &&
                  (state.products?.isNotEmpty ?? false)) {
                if (!state.isLastData) {
                  _enableContinueLoadMore = true;
                }
                return Expanded(
                    child: ListView(
                  padding: EdgeInsets.zero,
                  controller: widget.controller,
                  children: [
                    GridViewDisplayProductMapSearch(
                      label: '',
                      courses: state.products,
                    )
                  ],
                ));
              }
              return Text('loi');
            }),
        BlocBuilder<MapSearchProductScreenCubit, MapSearchScreenState>(
          bloc: _mapsearchCubit,
          builder: (_, state) {
            if (state is MapSearchScreenLoadingMoreState) {
              return CircularProgressIndicator(color: AppColors.grey5,);
            }
            return const SizedBox();
          },
        )

      ],
    );
  }
}
