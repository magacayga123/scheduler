import 'package:flutter/material.dart';
import 'package:scheduler/ui/widgets/custom_input_field.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({Key? key}) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final namecontroller = TextEditingController();
  final maximumframescontroller = TextEditingController();
  // final namecontroller = TextEditingController();
  var public = privateness.public;
  var routine = routiness.routine;
  @override
  void dispose() {
    // TODO: implement dispose
    namecontroller.dispose();
    maximumframescontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("scheduler app"),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              CustomInputField(
                  hint: "enter timetable name",
                  controller: namecontroller,
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {}, child: Text("choose starting date")),
                  Text(DateTime.now().toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: Text("choose end date")),
                      Text(DateTime.now().toString()),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).primaryColor),
                    width: double.infinity,
                    child: Text(
                        "enter this below maximum number of works you do in day likke 2 or 3 or 7"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomInputField(
                      hint: 'enter maximum number of work in a day',
                      controller: maximumframescontroller,
                      keyboardType: TextInputType.number),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Radio<privateness>(
                          value: public,
                          groupValue: privateness.private,
                          onChanged: (privateness? prn) {
                            setState(() {
                              public = privateness.private;
                            });
                          }),
                      Radio<privateness>(
                          value: public,
                          groupValue: privateness.public,
                          onChanged: (privateness? prn) {
                            setState(() {
                              public = privateness.public;
                            });
                          })
                    ],
                  )
                ],
              ),
            ]),
          ),
        ));
  }
}

enum privateness { private, public }
enum routiness { routine, onlyone }
