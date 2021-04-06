import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kar_administration/Helpers/Database.dart';

import '../../Constants.dart';
import 'Components/UnderScreenContainer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        leading: SizedBox.shrink(),
      ),

      // body: FutureBuilder<List<User>>(
      //   future: DBProvider.db.getAllUsers(),
      //   builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
      //     if (snapshot.hasData) {
      //       if (snapshot.data.isEmpty) {
      //         return Center(
      //             child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(
      //               "Database is Empty !",
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
      //           User item = snapshot.data[index];
      //
      //           return Dismissible(
      //             secondaryBackground: UnderScreenContainer(),
      //             key: UniqueKey(),
      //             background: UnderScreenContainer(),
      //             onDismissed: (direction) {
      //               DBProvider.db.deleteUser(item.id);
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
      //                         item.email,
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
      //
      //                   ),
      //                   CircleAvatar(
      //                       backgroundImage:
      //                           FileImage(File(snapshot.data[index].picture)),
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

      body: GridView(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: <Widget>[
          GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, "/projects"),
            child: Card(
              margin: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: ColorConstants.secondAppColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IconConstants.project,
                    color: Colors.white,
                    width: 60,
                  ),
                  SizedBox(height: 10,),
                  Text("Projects",style: AppTextStyle.boldTitle16.copyWith(color: Colors.white),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, "/persons"),
            child: Card(
              margin: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: ColorConstants.secondAppColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IconConstants.worker,
                    color: Colors.white,
                    width: 60,
                  ),
                  SizedBox(height: 10,),
                  Text("Workers",style: AppTextStyle.boldTitle16.copyWith(color: Colors.white),)
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: ColorConstants.secondAppColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IconConstants.day,
                  color: Colors.white,
                  width: 60,
                ),
                SizedBox(height: 10,),
                Text("Days",style: AppTextStyle.boldTitle16.copyWith(color: Colors.white),)
              ],
            ),
          ),
          GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, "/things"),
            child: Card(
              margin: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: ColorConstants.secondAppColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IconConstants.thing,
                    color: Colors.white,
                    width: 60,
                  ),
                  SizedBox(height: 10,),
                  Text("Things",style: AppTextStyle.boldTitle16.copyWith(color: Colors.white),)
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: ColorConstants.secondAppColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IconConstants.money,
                  color: Colors.white,
                  width: 60,
                ),
                SizedBox(height: 10,),
                Text("Money",style: AppTextStyle.boldTitle16.copyWith(color: Colors.white),)
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: ColorConstants.secondAppColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IconConstants.doc,
                  color: Colors.white,
                  width: 60,
                ),
                SizedBox(height: 10,),
                Text("Reports",style: AppTextStyle.boldTitle16.copyWith(color: Colors.white),)
              ],
            ),
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () async {
      //     User rnd = DummyData.testUsers[math.Random().nextInt(DummyData.testUsers.length)];
      //      var sss =await DBProvider.db.newUser(new User(IMEI: 123323,firstName: "fffff",lastName: "sjjdjj",email: "wsdsdsd",picture: "Ewqdeqdw",passport: 121313,doB:"12-12-2020",deviceName: "IOS :",lat: 12.222,lng: 23.333));
      //      print(sss);
      //     setState(() {});
      //   },
      // ),
    );
  }
}
