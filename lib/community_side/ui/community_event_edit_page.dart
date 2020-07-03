import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karo_app/community_side/components/custom_box_decoration.dart';
import 'package:karo_app/community_side/components/custom_submit_button.dart';
import 'package:karo_app/community_side/components/build_avatar_container.dart';
import 'package:karo_app/community_side/components/build_background_bottom_circle.dart';
import 'package:karo_app/community_side/components/build_text_form_field.dart';
import 'package:karo_app/community_side/components/build_top_circle.dart';
import 'package:karo_app/community_side/ui/community_homepage.dart';
import 'package:karo_app/models/event.dart';
import 'package:karo_app/utils/database_helper.dart';

class CommunityEventEditPage extends StatefulWidget {
  Event event;
  int community_id;
  CommunityEventEditPage({@required this.event, @required this.community_id});
  @override
  _CommunityEventEditPageState createState() => _CommunityEventEditPageState();
}

class _CommunityEventEditPageState extends State<CommunityEventEditPage> {
  final blueColor = Color(0XFF5e92f3);
  final yellowColor = Color(0XFFfdd835);

  final formKey = GlobalKey<FormState>();
  bool otoValidation = false;

  DateTime selectedDate;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  ////////////FOCUS NODES
  final _titleNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _dateTimeNode = FocusNode();
  final _locationNode = FocusNode();
  final _quotaNode = FocusNode();

  ////////////TEXT EDITING CONTROLLERS
  TextEditingController titleController;
  TextEditingController descriptionController;
  TextEditingController locationController;
  TextEditingController quotaController;

  DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.event.eventTitle);
    descriptionController = TextEditingController(text: widget.event.eventDesc);
    locationController =
        TextEditingController(text: widget.event.eventLocation);
    quotaController =
        TextEditingController(text: widget.event.quota.toString());
    selectedDate = DateTime.parse(widget.event.eventDateTime);

    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blueColor,
        ),
        body: Stack(
          children: [
            BuildTopCircle(
              offSetValue: 1.3,
            ),
            BuildBackgroundBottomCircle(blueColor),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.37,
              child: Column(
                children: <Widget>[
                  Text(
                    "UPDATE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  BuildAvatarContainer(icon: Icons.settings),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOutBack,
                        height: 530,
                        margin: EdgeInsets.only(top: 30),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        child: buildTextFieldsSection(),
                      ),
                      CustomSubmitButton(
                        onPressedFunction: updateEventButtonFunction,
                        buttonName: "UPDATE",
                        buttonColor: blueColor,
                        buttonTextColor: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Form buildTextFieldsSection() {
    return Form(
      autovalidate: otoValidation,
      key: formKey,
      child: Column(
        children: <Widget>[
          Expanded(
            child: BuildTextFormField(
              labelText: "Title",
              placeholder: "Event title",
              isPassword: false,
              maxLength: null,
              inputType: TextInputType.text,
              focusNode: _titleNode,
              controller: titleController,
              validatorFunction: (value) {
                return titleValidator(value);
              },
              prefixIcon: null,
            ),
          ),
          Expanded(
            child: BuildTextFormField(
              labelText: "Description",
              placeholder: "Event description",
              isPassword: false,
              maxLength: null,
              inputType: TextInputType.text,
              focusNode: _descriptionNode,
              controller: descriptionController,
              validatorFunction: (value) {
                return descriptionValidator(value);
              },
              prefixIcon: null,
            ),
          ),
          showDate(),
          Expanded(
            child: BuildTextFormField(
              labelText: "Location",
              placeholder: "Event location",
              isPassword: false,
              maxLength: null,
              inputType: TextInputType.text,
              focusNode: _locationNode,
              controller: locationController,
              validatorFunction: (value) {
                return locationValidator(value);
              },
              prefixIcon: null,
            ),
          ),
          Expanded(
            child: BuildTextFormField(
              labelText: "Quota",
              placeholder: "Event quota",
              isPassword: false,
              maxLength: null,
              inputType: TextInputType.number,
              controller: quotaController,
              focusNode: null,
              validatorFunction: (value) {
                return quotaValidator(value);
              },
              prefixIcon: null,
            ),
          ),
        ],
      ),
    );
  }

/////////////VALIDATORS FOR FORM////////////
  String titleValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter title for event';
    }
    return null;
  }

  String descriptionValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter description for event';
    }
    // if (value.length < 10) {
    //   return 'Length of description should be longer than 10';
    // }
    return null;
  }

  String locationValidator(String value) {
    if (value.isEmpty) {
      return "Please enter location of event";
    }
    return null;
  }

  String quotaValidator(String value) {
    if (value.isEmpty) {
      return "Please enter quota for event";
    }
    try {
      int i = int.parse(value);
    } catch (e) {
      return "Quota should be a number";
    }
    return null;
  }

//DATE PICKER METHODS///////////////////
  Future<TimeOfDay> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
////////////////////////////////////////
  ///SHOW DATE TIME/////////////////////
  Expanded showDate() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Choose date",
                  style: TextStyle(color: blueColor, fontSize: 12),
                ),
                InkWell(
                  splashColor: Colors.blue,
                  highlightColor: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.white,
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                        onPressed: () async {
                          final _selectedDate = await _selectDateTime(context);
                          if (selectedDate == null) return;

                          final _selectedTime = await _selectTime(context);
                          if (_selectedTime == null) return;

                          setState(() {
                            selectedDate = DateTime(
                              _selectedDate.year,
                              _selectedDate.month,
                              _selectedDate.day,
                              _selectedTime.hour,
                              _selectedTime.minute,
                            );
                          });
                        },
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        height: 40,
                        decoration:
                            CustomBoxDecoration().create(Colors.white, 10),
                        child: Text(
                          dateFormat.format(selectedDate),
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///ADD BUTTON FUNCTION/////////////
  void updateEventButtonFunction() async {
    if (formKey.currentState.validate()) {
      _databaseHelper.updateEvent(
          widget.event.eventID,
          titleController.text,
          descriptionController.text,
          selectedDate.toString(),
          locationController.text,
          int.parse(quotaController.text));
      print("Updated");
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => CommunityHomepage(
                      community_id: widget.community_id,
                    )),
            (route) => false);
      });
    } else {
      print("Not Updated");
      setState(() {
        otoValidation = true;
      });
    }
  }
}
