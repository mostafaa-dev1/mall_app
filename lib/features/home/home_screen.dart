import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_app/cubit.dart';
import 'package:mall_app/setting.dart';
import 'package:mall_app/states.dart';
import 'package:mall_app/winner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   actions: [
          //     IconButton(
          //       onPressed: (){
          //         AppCubit.get(context).GetData();
          //       },
          //       icon: Icon(
          //         Icons.refresh,
          //         color: Colors.black,
          //         size: 25,
          //       )
          //     )
          //   ],
          //     centerTitle: true,
          //     title: Text(
          //         'All data',
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold
          //         )
          //     )
          // ),
          body: state is GetDataLoadingState
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (AppCubit.get(context).dateTime == null) {
                                  AppCubit.get(context).GetDate();
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Setting()));
                              },
                              icon: Icon(
                                Icons.settings,
                                color: Colors.black,
                              )),
                          Text('All data',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                          IconButton(
                              onPressed: () {
                                AppCubit.get(context).GetData();
                                // AppCubit.get(context).set();
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.black,
                              ))
                        ],
                      ),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[100]!,
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        )
                                      ]),
                                  child: Row(children: [
                                    Text('${index + 1}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 1,
                                      color: Colors.grey[300],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        AppCubit.get(context).users[index]
                                            ['phone'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))
                                  ]));
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: AppCubit.get(context).users.length),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                  onPressed: () async {
                                    AppCubit.get(context).GetRandom();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Winner()));
                                    // final response = await Supabase.instance.client.from('Users').select('*');
                                    // print(response);
                                  },
                                  child: Text('Choose random winner',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
