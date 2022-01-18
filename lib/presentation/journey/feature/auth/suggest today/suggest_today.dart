import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/constants/home_constant.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/ultils/log_util.dart';
import 'package:my_gstore/presentation/injector_container.dart';
import 'package:my_gstore/presentation/journey/feature/auth/suggest%20today/cubit/suggest_today_cubit.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/gridview_product.dart';

import 'cubit/suggest_today_state.dart';

class SuggestToDay extends StatefulWidget {
  final ScrollController scrollController;
  const SuggestToDay({
    Key? key,
    // required this.courses,
    required this.scrollController,
  }) : super(key: key);

  @override
  _SuggestToDayState createState() => _SuggestToDayState();
}

class _SuggestToDayState extends State<SuggestToDay> {
final  SuggestTodayCubit _suggestTodayCubit = injector<SuggestTodayCubit>();
bool _enableContinueLoadMore = true;
bool _runFirst = true;

@override
void initState() {
  widget.scrollController.addListener(_scrollListener);
  super.initState();
}

void _scrollListener() {
  if (widget.scrollController.position.extentAfter < 100) {
    if (_enableContinueLoadMore) {
      _enableContinueLoadMore = false;
      if (_runFirst) {
        _runFirst = false;
        _suggestTodayCubit.getDataSuggestToday();
      } else {
        _suggestTodayCubit.getMoreSuggestToday();
      }
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
     BlocBuilder<SuggestTodayCubit,SuggestTodayState>(
         bloc: _suggestTodayCubit,
         buildWhen: (_, state) {
           return state is SuggestTodayGettingDataState ||
               state is SuggestTodayGotState;
         },
         builder: (_,state){
           if(state is SuggestTodayGettingDataState){
             return CircularProgressIndicator(color: AppColors.grey5,);
           }
           if(state is SuggestTodayGotState && (state.products?.isNotEmpty ?? false)){
             if (!state.isLastData) {
               _enableContinueLoadMore = true;
             }
             return  GridViewDisplayProduct(
               label: HomeConstant.suggestToday,
               courses:state.products,
             );
           }
           return Text('Loi');
         }),
        BlocBuilder<SuggestTodayCubit, SuggestTodayState>(
          bloc: _suggestTodayCubit,
          builder: (_, state) {
            if (state is SuggestTodayLoadingMoreState) {
              return CircularProgressIndicator(color: AppColors.grey5,);
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}
