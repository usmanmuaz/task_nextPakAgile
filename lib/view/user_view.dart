import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:next_pak_agile_task/model/dummy_data_model.dart';
import 'package:next_pak_agile_task/model/user_model.dart';
import 'package:next_pak_agile_task/widgets/Expandable_tile.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    // Total Screen Width
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            height: screenWidth <= 375 ? 350.h : 325.h,
            width: double.infinity,
            padding: EdgeInsets.only(
                left: 15.w, right: 15.w, top: 10.h, bottom: 30.h),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.blue.shade100,
              Colors.blue.shade200,
              Colors.blue.shade300,
              Colors.blue.shade500,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: FutureBuilder<QuerySnapshot>(
                future: users.get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  // WAITING FOR DATA
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  }

                  // ERROR MESSAGE
                  if (snapshot.hasError) {
                    return const Text("ERROR OCCURED");
                  }

                  // Mapping Data in Users List
                  List<User> users = [];
                  for (QueryDocumentSnapshot document in snapshot.data!.docs) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    users.add(User(
                      name: data['name'],
                      image: data['image'],
                      metres: data['metres'],
                      minutes: data['minutes'],
                      calories: data['calories'],
                      steps: data['steps'],
                      metresPerMinute: data['metres/min'],
                    ));
                  }

                  // OUR USER DATA FROM FIRESTORE
                  return SafeArea(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/menu_icon.svg",
                              height: 13.h,
                              width: 13.w,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: screenWidth <= 375 ? 75.w : 90.w,
                            ),
                            Text(
                              "Kalories Rank",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            const Spacer()
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "NO. 1",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: screenWidth <= 375 ? 80.w : 90.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    radius: 40.sp,
                                    backgroundImage:
                                        NetworkImage(users[0].image)),
                                Text(
                                  users[0].name,
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Reduce fat",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const Spacer()
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            reusableVertData(
                                "Steps", users[0].steps.toString()),
                            reusableVertData(
                                "Minutes", users[0].minutes.toString()),
                            reusableVertData(
                                "Metres", users[0].metres.toString()),
                            reusableVertData(
                                "Calories", users[0].calories.toString()),
                            reusableVertData("Metre/min",
                                users[0].metresPerMinute.toString()),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),

        // Expandable Tile Widget
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(bottom: 20.h),
            children: List.generate(
                DummyData.names.length,
                (i) => ExpandableTIle(
                      name: DummyData.names[i],
                      image: DummyData.images[i],
                      category: DummyData.category[i],
                      activeIndex: i,
                    )),
          ),
        )
      ],
    ));
  }
}

// Reusable Vertical Data
Widget reusableVertData(String text, String data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        data,
        style: TextStyle(
            fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w400),
      ),
      SizedBox(
        height: 5.h,
      ),
      Text(
        text,
        style: TextStyle(
            fontSize: 10.sp, color: Colors.white, fontWeight: FontWeight.w400),
      ),
    ],
  );
}
