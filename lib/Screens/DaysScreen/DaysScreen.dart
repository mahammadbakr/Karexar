import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kar_administration/Helpers/Database.dart';
import 'package:kar_administration/Models/Person.dart';
import 'package:kar_administration/Models/Project.dart';
import 'package:kar_administration/Screens/HomeScreen/Components/UnderScreenContainer.dart';

import '../../Constants.dart';

class DaysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Days Screen",
          style:
              AppTextStyle.regularTitle20.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(child: Text("dayssss"),),
      // body: FutureBuilder<List<Person>>(
      //   future: DBProvider.db.getAllPersons(),
      //   builder: (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
      //     if (snapshot.hasData) {
      //       if (snapshot.data.isEmpty) {
      //         return Center(
      //             child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(
      //               "Workers are Empty !",
      //               style: AppTextStyle.boldTitle20
      //                   .copyWith(color: ColorConstants.blackAppColor),
      //             ),
      //             Text(
      //               "Click Button Below for adding new data!",
      //               style: AppTextStyle.thinTitle10
      //                   .copyWith(color: ColorConstants.blackAppColor),
      //             ),
      //           ],
      //         ));
      //       }
      //       return ListView.builder(
      //         itemCount: snapshot.data.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           Person item = snapshot.data[index];
      //
      //           return Dismissible(
      //             secondaryBackground: UnderScreenContainer(),
      //             key: UniqueKey(),
      //             background: UnderScreenContainer(),
      //             onDismissed: (direction) {
      //               DBProvider.db.deleteProject(item.id);
      //             },
      //             child: Padding(
      //               padding:
      //                   const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
      //               child: Row(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: [
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         item.firstName,
      //                         style: AppTextStyle.regularTitle16,
      //                       ),
      //                       Text(
      //                         item.secondName,
      //                         style: AppTextStyle.thinTitle12,
      //                       ),
      //                     ],
      //                   ),
      //                   Spacer(),
      //                   IconButton(
      //                     icon: Icon(
      //                       Icons.location_on,
      //                       color: ColorConstants.mainAppColor,
      //                       size: 24,
      //                     ),
      //                   ),
      //                   CircleAvatar(
      //                       backgroundImage:
      //                           FileImage(File(snapshot.data[index].image)),
      //                       radius: 20,
      //                       backgroundColor: Colors.white),
      //                 ],
      //               ),
      //             ),
      //           );
      //         },
      //       );
      //     } else {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, "/addDay")
      ),
    );
  }
}
