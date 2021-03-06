import 'package:get_it/get_it.dart';
import 'package:my_gstore/common/bloc/event_bus/event_bus_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/local/local_app.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/presentation/journey/feature/auth/all%20product/Cubit/all_product_cubit.dart';
import 'package:my_gstore/presentation/journey/feature/auth/individual/cubit/individual_cubit.dart';
import 'package:my_gstore/presentation/journey/feature/auth/otp/otp_cubit.dart';
import 'package:my_gstore/presentation/journey/feature/auth/suggest%20today/cubit/suggest_today_cubit.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Home/cubit/home_cubit.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Notification/cubit/notification_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'journey/feature/auth/detail product page/cubit/detail_cubit.dart';
import 'journey/feature/auth/g shop page/cubit/gshop_infor_cubit.dart';
import 'journey/feature/auth/login/cubit/login_with_phone_cubit.dart';
import 'journey/feature/screens/Category/Cubit/category_cubit.dart';
import 'journey/feature/screens/Search product screen/cubit/map_search_screen_cubit.dart';
import 'journey/feature/screens/gshop map screen/cubit/map_search_gshop_cubit.dart';

final injector = GetIt.instance;

Future<void> init() async {
  _initCommon();
  _initBloc();
}

void _initBloc() {
  injector.registerLazySingleton(() => EventBusBloc());
  injector.registerLazySingleton(() => LoadingBloc());
  injector.registerLazySingleton(() => SnackBarBloc());
  injector.registerLazySingleton(() => GlobalAppCache());
  injector.registerFactory(() => LoginWithPhoneCubit(
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory(() => OtpCubit(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory(() => HomeCubit(
    injector(),
    injector(),
    injector(),
  ));
  injector.registerFactory(() => CategoryCubit(
    injector(),
    injector(),
    injector(),
  ));
  injector.registerFactory(() => IndividualCubit(
    injector(),
    injector(),
    injector(),
  ));
  injector.registerFactory(() => DetailProductCubit(
    injector(),
    injector(),
    injector(),
  ));
  injector.registerFactory(() => NotificationCubit(
    injector(),
    injector(),
    injector(),
  ));
  injector.registerFactory(() => MapSearchProductScreenCubit(
    injector(),
    injector(),
    injector(),
  ));
  injector.registerFactory(() => MapGShopScreenCubit(
    injector(),
    injector(),
    injector(),
  ));
  injector.registerFactory(() => SuggestTodayCubit(
    injector(),
    injector(),
    injector(),
  ));
  injector.registerFactory(() => AllProductCubit(
    injector(),
    injector(),
    injector(),
  ));
  injector.registerFactory(() => GShopPageCubit(
    injector(),
    injector(),
    injector(),
  ));
}

void _initCommon() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  injector.registerLazySingleton(
      () => sharedPreferences); // l??u tr??? th??ng tin, d??? li???u
  injector.registerLazySingleton(
    () => AppClient(
      injector(),
      injector(),
    ),
  );
  injector.registerLazySingleton(
    () => LocalApp(
      injector(),
    ),
  );
}
