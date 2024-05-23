import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_app/cubit.dart';
import 'package:mall_app/states.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}
DateTime? selectedDateTime;
DateTime? setDateTime;
class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        if(state is GetDateSuccessState){
          setState(() {
            setDateTime = AppCubit.get(context).dateTime;
          });
        }
      },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Text(
                  'Setting',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  )
              )
          ),
          body: state is GetDateLoadingState ? Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ):Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Date of the next winner',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                       Text(
                          setDateTime==null?'No date set yet':'$setDateTime',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          )
                      ),
                      Spacer(),
                      state is SetDateLoadingState ? CircularProgressIndicator(
                        color: Colors.blue,
                      ):ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: (){
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            ).then((pickedDate) {
                              if (pickedDate != null) {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((pickedTime) {
                                  if (pickedTime != null) {
                                    setState(() {
                                      selectedDateTime = DateTime(
                                        pickedDate.year,
                                        pickedDate.month,
                                        pickedDate.day,
                                        pickedTime.hour,
                                        pickedTime.minute,
                                      );
                                    });
                                    ArtSweetAlert.show(
                                        context: context,
                                        artDialogArgs: ArtDialogArgs(
                                            confirmButtonColor: Colors.blue,
                                            cancelButtonColor: Colors.black,
                                            onConfirm: (){
                                              AppCubit.get(context).setDate(dateTime: selectedDateTime!);
                                              setState(() {
                                                setDateTime = selectedDateTime;
                                              });
                                              Navigator.pop(context);
                                            },
                                            customColumns: [
                                              Column(
                                                  children: [
                                                    Text(
                                                        'Are you sure you want to set this date?',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500
                                                        )
                                                    ),
                                                    Text(
                                                        '($selectedDateTime)',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold
                                                        )
                                                    )
                                                  ]
                                              )
                                            ]
                                        )
                                    );
                                  }
                                });
                              }
                            });
                          },
                          child:  Text(
                              setDateTime==null?'Chose date':'Change',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                              )
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
