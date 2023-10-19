import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:million/theme/app_colors.dart';

class DropdownTextFiled extends StatefulWidget {
  final String? hint;
  final ValueChanged<String>? onChanged;
  final bool? depth;
  final bool? isSelected;
  final bool? isFlagList;
  final bool? isEditProfile;
  final bool? isFilterScreen;
  final bool? loading;

  DropdownTextFiled({
    @required this.hint,
    this.onChanged,
    this.depth = false,
    this.isSelected,
    this.isFlagList,
    this.isEditProfile,
    this.isFilterScreen,
    this.loading = false,
  });

  @override
  __TextFieldState createState() => __TextFieldState();
}

class __TextFieldState extends State<DropdownTextFiled> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.hint);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 30,
          padding: EdgeInsets.only(top: 0),
          child: Neumorphic(
            style: NeumorphicStyle(
              depth: 0,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
            ),
            child: !widget.loading!
                ? Container(
                    width: MediaQuery.of(context).size.width - 40,
                    padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: widget.isFilterScreen == true ? 10 : 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                height: 30,
                                width: MediaQuery.of(context).size.width - 100,
                                child: Text(
                                  this.widget.hint!,
                                  style: TextStyle(
                                      height: 1.8,
                                      fontFamily: "DMSans",
                                      fontSize: 14,
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Spacer(),
                              widget.isFlagList == false
                                  ? Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: 25,
                                      color: AppColors.whiteColor,
                                    )
                                  : SizedBox(
                                      width: 0,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
