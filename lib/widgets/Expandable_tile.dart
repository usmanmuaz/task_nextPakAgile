import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_pak_agile_task/provider/expanded_tile_provider.dart';
import 'package:next_pak_agile_task/widgets/reusable_vert_data.dart';
import 'package:provider/provider.dart';

class ExpandableTIle extends StatefulWidget {
  final int activeIndex;

  final String name;
  final String image;
  final String category;
  const ExpandableTIle({
    super.key,
    required this.name,
    required this.image,
    required this.category,
    required this.activeIndex,
  });

  @override
  State<ExpandableTIle> createState() => _ExpandableTIleState();
}

class _ExpandableTIleState extends State<ExpandableTIle> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SelectedTileProvider>(context);
    return GestureDetector(
      onTap: () {
        provider.toggleVisibility(widget.activeIndex);
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 20.h,
          left: 20.w,
          right: 20.w,
        ),
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade400, width: 0.5)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: provider.isVisible(widget.activeIndex)
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Text(
                  "NO. ${widget.activeIndex + 2}",
                  style: TextStyle(
                      color: Colors.blue.shade300,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 30.sp,
                        backgroundImage: NetworkImage(widget.image)),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        Text(
                          widget.category,
                          style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Image.asset(
                  provider.isVisible(widget.activeIndex)
                      ? "assets/arrow_up.png"
                      : "assets/arrow_down.png",
                  height: provider.isVisible(widget.activeIndex) ? 15.h : 20.h,
                  width: provider.isVisible(widget.activeIndex) ? 15.w : 20.w,
                )
              ],
            ),
            Visibility(
                visible: provider.isVisible(widget.activeIndex),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableVertData(
                          text: "Steps",
                          data: "138759",
                          textColor: Colors.black.withOpacity(.5),
                          dataColor: Colors.black,
                        ),
                        ReusableVertData(
                          text: "minutes",
                          data: "86007",
                          textColor: Colors.black.withOpacity(.5),
                          dataColor: Colors.black,
                        ),
                        ReusableVertData(
                          text: "metres",
                          data: "50000",
                          textColor: Colors.black.withOpacity(.5),
                          dataColor: Colors.black,
                        ),
                        ReusableVertData(
                          text: "calories",
                          data: "6970",
                          textColor: Colors.black.withOpacity(.5),
                          dataColor: Colors.black,
                        ),
                        ReusableVertData(
                          text: "metre/min",
                          data: "30",
                          textColor: Colors.black.withOpacity(.5),
                          dataColor: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
