import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mall_app/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  List<Map<String, dynamic>> users = [];
  Future<void> GetData() async {
    users = [];
    emit(GetDataLoadingState());
    final response =
        await Supabase.instance.client.from('Users').select('*').then((value) {
      users = value;
      print(users);
      emit(GetDataSuccessState());
    }).catchError((e) {
      emit(GetDataErrorState());
    });
  }

  String? winner;
  void GetRandom() {
    int randomIndex = Random().nextInt(users.length);
    String randomValue = users[randomIndex]['phone'];
    winner = randomValue;
    print("Random Value: $randomValue");
    // Get the random value from the list
  }

  Future<void> setDate({required DateTime dateTime}) async {
    print(dateTime);
    emit(SetDateLoadingState());
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
    print(formattedDate);
    await Supabase.instance.client
        .from('Info')
        .update({'date': formattedDate})
        .eq('id', 1)
        .then((value) {
          emit(SetDateSuccessState());
        })
        .catchError((e) {
          emit(SetDateErrorState());
        });
  }

  DateTime? dateTime;
  Future<void> GetDate() async {
    emit(GetDateLoadingState());
    await Supabase.instance.client.from('Info').select('date').then((value) {
      dateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(value[0]['date']);
      print(dateTime);
    }).then((value) {
      emit(GetDateSuccessState());
    });
  }

  Future<void> set() async {
    print(1);
    emit(GetDateLoadingState());
    await Supabase.instance.client;
  }
}
