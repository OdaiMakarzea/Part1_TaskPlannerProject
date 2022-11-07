import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {

  List<Map<String,dynamic>> tasks = [
    {
      "Title": "Go to the Gym",
      "date": DateFormat('EEE, MMM d, ''yyyy').format(DateTime.utc(2022,10,30)),
      "checked": false,
    },
    {
      "Title": "Coding",
      "date": DateFormat('EEE, MMM d, ''yyyy').format(DateTime.utc(2022,10,30)),
      "checked": false,

    },
    {
      "Title": "Swimming",
      "date": DateFormat('EEE, MMM d, ''yyyy').format(DateTime.utc(2022,10,30)),
      "checked": false,

    },
  ];
  List<Map<String,dynamic>> tasksCompleted = [];
  final PanelController _pc = PanelController();
  bool openPanel = true;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: openPanel,
        child: FloatingActionButton(
          clipBehavior: Clip.antiAlias,
          child: const Icon(Icons.add),
          onPressed: () {
             setState(() {
               openPanel = false;
             });
            _pc.open();
          },),
      ),
      appBar: AppBar(title: Text("Inbox Page")),
      body: SlidingUpPanel(
        renderPanelSheet: false,
        backdropEnabled: true,
        minHeight: 10,
        maxHeight: 100,
        collapsed: Stack(
        //  clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 50,
              bottom: 220,
                child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    /*setState(() {
                      openPanel = false;
                    });*/
                    setState(() {

                    });
                    _pc.open();
                  },),
            ),
          ],
        ),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
        controller: _pc,
        panel: Container(
          color: Colors.white,
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: "Type Task name here",
                  border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10)
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container(padding: const EdgeInsets.only(left: 10),child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                     // Text("COMPLETED",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                      Icon(Icons.calendar_today_rounded,color: Colors.grey,size: 20,),
                      Icon(Icons.flag_rounded,color: Colors.grey,size: 20,),
                      Icon(Icons.file_copy_rounded,color: Colors.grey,size: 20,),
                      Icon(Icons.save_outlined,color: Colors.grey,size: 20,),
                      Text("Inbox",style: TextStyle(color: Colors.grey),)
                    ],
                  ))),
                  VerticalDivider(width: 1.0),
                  Expanded(child: Container(padding: EdgeInsets.only(right: 5),alignment: Alignment.topLeft,
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(icon: Icon(Icons.arrow_forward,size: 30,),color: Colors.white,
                            onPressed: () {

                              DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                maxTime: DateTime(2099, 12, 31),
                                theme: DatePickerTheme(
                                    headerColor: Colors.indigo.shade200,
                                    backgroundColor: Colors.indigo.shade100,
                                    itemStyle: const TextStyle(
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),

                                    doneStyle: const TextStyle(color: Colors.indigo, fontSize: 20),
                                    cancelStyle: const TextStyle(color: Colors.blueGrey, fontSize: 20)

                                ),
                                onConfirm: (date) {
                                  setState(() {
                                    tasks.add({
                                      "Title": controller.text,
                                      "date": date,
                                      "checked": false
                                    });
                                    _pc.close();
                                    controller.clear();
                                  });
                                  },
                              );
                            },)),
                    ],
                  ))),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(1),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.black,width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      Container(color: Colors.red,),
                      Container(color: Colors.blue,),
                    ],
                  ),
                  ...List.generate(tasks.length  , (index) =>
                    tasks[index]['checked'] == false ?
                    CheckboxListTile(
                          value: tasks[index]['checked'],
                          title: Text("${tasks[index]['Title']}"),
                          secondary: Text("${tasks[index]['date']}",style: TextStyle(color: Colors.blue),),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            setState(() {
                              tasks[index]['checked'] = value;
                              tasksCompleted.add({
                                "Title": tasks[index]['Title'],
                                "date": tasks[index]['date'],
                                "checked": true
                              });
                            });
                          },
                          activeColor: Colors.blue,
                          checkColor: Colors.black,
                        ) : SizedBox.shrink()
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(1),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black,width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container(padding: const EdgeInsets.only(left: 10),child: Text("COMPLETED",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),))),
                      VerticalDivider(width: 1.0),
                      Expanded(child: Container(alignment: Alignment.centerRight,child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${tasksCompleted.length}"),
                          Icon(Icons.arrow_downward),
                        ],
                      ))),
                    ],
                  ),

                  ...List.generate(tasksCompleted.length, (index) =>  CheckboxListTile(
                      value: tasks[index]['checked'],
                      enabled: false,
                      title: Text("${tasks[index]['Title']}"),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (value) {
                        setState(() {
                          tasks[index]['checked'] = value;
                        });
                      },
                      activeColor: Colors.blue,
                      checkColor: Colors.black,
                    ),
                   ),
                ],
              ),
            ),
          ],
      ),
      ),
    );
  }
}



