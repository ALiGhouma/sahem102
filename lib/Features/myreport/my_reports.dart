import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Core/utils/space_adder.dart';
import 'package:sahem/Features/auth/data/user_model.dart';

class ReportHistory extends StatelessWidget {
  ReportHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> typelist = ['نظافة عامة', 'انقطاع كهرباء', 'ازدحام'];
    List<bool> isActiveList = [true, false, true]; // Example boolean list

    bool isDoen;
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('addresses')
          .get(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          // Use address ID to fetch reports with the same ID
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var reportData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(15),
                  Container(
                    width: 380,
                    height: 81,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ColorManager.primary)),
                    child: Row(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("نوع البلاغ", style: getRegularStyle()),
                          Text("${typelist[index]}", style: getRegularStyle()),
                          // Add the selectable items here
                          // You can use typelist to map through the items
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.call_missed_outlined),
                              isActiveList[index]
                                  ? Text("مفعل", style: getRegularStyle())
                                  : Text("غير مفعل", style: getRegularStyle()),
                            ],
                          ),

                          Text("22/01/2024"),
                          // Add the selectable items here
                          // You can use typelist to map through the items
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        // Add the status here based on your logic
                      )
                    ]),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
