// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:taskify/models/user.dart';
import 'package:taskify/utils/shared.dart';
import 'package:taskify/widgets/labeltext.dart';
import 'package:taskify/widgets/photoprofile.dart';
import 'package:taskify/widgets/todolistbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColour,
        appBar: AppBarToDoList.buildAppBar(context, "My Profile"),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.elliptical(64, 46),
                  topRight: Radius.elliptical(64, 46),
                ),
                color: backgroundColour,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.elliptical(64, 46),
                    topRight: Radius.elliptical(64, 46),
                  ),
                  color: backgroundColour,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          PhotoProfile(),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      LabelText(title: "Name"),
                      Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          decoration: inputDecoration(
                            hintText: (user != null) && (user!.name != "")
                                ? user!.name
                                : "Enter the name",
                            profile: true,
                          ),
                          style: defaultText.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                          ),
                          onChanged: (value) {
                            setState(
                              () {
                                if (user != null) {
                                  user!.name = value;
                                } else {
                                  user = User(
                                    name: value,
                                    major: "Ilmu Komputer",
                                    dateBirth: "Jan-1-2000",
                                    email: "",
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LabelText(title: "Major"),
                      Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(10),
                        child: DropdownButtonFormField(
                          dropdownColor: backgroundColour,
                          value:
                              (user != null) ? user!.major : "Ilmu Komputer",
                          items: const [
                            DropdownMenuItem(
                              value: "Ilmu Komputer",
                              child: Text("Ilmu Komputer"),
                            ),
                            DropdownMenuItem(
                              value: "Sistem Informasi",
                              child: Text("Sistem Informasi"),
                            ),
                          ],
                          onChanged: (value) {
                            if (user != null) {
                              user!.major = value!;
                            } else {
                              user = User(
                                name: "",
                                major: value!,
                                dateBirth: "Jan-1-2000",
                                email: "",
                              );
                            }
                          },
                          icon: Icon(
                            Icons.arrow_drop_down_circle_rounded,
                            color: primaryColour,
                          ),
                          decoration:
                              inputDecoration(labelText: "", profile: true),
                          style: defaultText.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LabelText(title: "Date a Birth"),
                      TextField(
                        controller: dateInput,
                        decoration: inputDecoration(
                          prefixIcon: CupertinoIcons.calendar,
                          hintText: user != null
                              ? user!.dateBirth
                              : "Select the date",
                          profile: true,
                        ),
                        style: defaultText.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800,
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            initialEntryMode: DatePickerEntryMode.calendar,
                            builder: (BuildContext context, child) {
                              return themeData(context, child);
                            },
                          );
        
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('MMM-d-y').format(pickedDate);
                            setState(() {
                              if (user != null) {
                                user!.dateBirth = formattedDate;
                              } else {
                                user = User(
                                  name: "",
                                  major: "Ilmu Komputer",
                                  dateBirth: formattedDate,
                                  email: "",
                                );
                              }
                              dateInput.text = formattedDate;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LabelText(title: "Email"),
                      Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          decoration: inputDecoration(
                            hintText: (user != null) && (user!.email != "")
                                ? user!.email
                                : "Enter the email",
                            profile: true,
                          ),
                          style: defaultText.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (user != null) {
                                user!.email = value;
                              } else {
                                user = User(
                                  name: "",
                                  major: "Ilmu Komputer",
                                  dateBirth: "",
                                  email: value,
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
