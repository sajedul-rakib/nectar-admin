import 'package:admin_panel/controller/controller.dart';
import 'package:admin_panel/src/bloc/blocs.dart';
import 'package:admin_panel/src/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_repo/product_repository.dart';
import 'package:provider/provider.dart';
import 'package:user_repo/user_repository.dart';

class MainApp extends StatelessWidget {
  final UserRepo userRepo;
  final ProductRepo productRepo;
  const MainApp({super.key, required this.userRepo, required this.productRepo});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DrawerMenuController())
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AuthenticationBloc(userRepo: userRepo),
          ),
          RepositoryProvider(
            create: (context) => LoginBlocBloc(userRepo: userRepo),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => AuthenticationBloc(userRepo: userRepo)),
            BlocProvider(
                create: (context) => LoginBlocBloc(userRepo: userRepo)),
            BlocProvider(
                create: (context) =>
                    ProductUploadBloc(productRepo: productRepo))
          ],
          child: ScreenUtilInit(
            designSize: const Size(360, 690),
            child: MaterialApp.router(
              routerConfig: AppRoute.router,
              debugShowCheckedModeBanner: false,
            ),
          ),
        ),
      ),
    );
  }
}
