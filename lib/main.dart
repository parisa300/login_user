
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neww/features/auth/domain/repositories/auth_repository.dart';
import 'package:neww/features/auth/presentation/bloc/profile/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/data/datasource/auth_remote_datasource.dart';
import 'features/auth/data/datasource/profile_remote_datasource.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/data/repository/profile_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/profile_usecase.dart';
import 'features/auth/domain/usecases/verify_use_case.dart';
import 'features/auth/presentation/bloc/login/login_bloc.dart';
import 'features/auth/presentation/bloc/verify/verify_bloc.dart';
import 'features/auth/presentation/page/login_page.dart';
import 'features/auth/presentation/page/profile_page.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final authRepository = AuthRepositoryImpl(AuthRemoteDataSource());
  final profileRepository = ProfileRepositoryImpl(ProfileRemoteDataSource());

    Widget? page;
    final prefs = await SharedPreferences.getInstance();
    String? chack = prefs.getString('access_token');
    if (chack != null && chack.isNotEmpty) {
       page = ProfilePage();
    } else {
      page= LoginPage();
    }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_)=>ProfileBloc(GetProfile(profileRepository)),
        ),
        BlocProvider(
          create: (context) => LoginBloc(LoginUseCase(authRepository)),
        ),
        BlocProvider(
          create: (context) => VerifyBloc(VerifyUseCase(authRepository)),
        ),

      ],
      child:  MyApp(homePage: page,),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget homePage;
  const MyApp({super.key,required this.homePage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: homePage,
    );
  }
}


