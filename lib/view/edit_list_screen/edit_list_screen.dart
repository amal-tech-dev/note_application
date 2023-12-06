import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/model/list_model.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/view/edit_list_screen/edit_list_widgets/edit_list_item.dart';
import 'package:note_application/view/home_screen/home_screen.dart';
import 'package:note_application/view/notes_screen/notes_screen.dart';

class EditListScreen extends StatefulWidget {
  String appBarTitle;
  String title;
  List<String>? contentList;
  int? noteKey;

  EditListScreen({
    super.key,
    required this.appBarTitle,
    this.title = '',
    this.contentList,
    this.noteKey,
  });

  @override
  State<EditListScreen> createState() => _EditListScreenState();
}

class _EditListScreenState extends State<EditListScreen> {
  int counter = 0;
  List keysList = [];
  List<String> checkList = [];
  final separatorBox = SizedBox(height: 15, width: 15);
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    initialiseHive();
    super.initState();
  }

  Future<void> initialiseHive() async {
    var box = await Hive.box<ListModel>('listBox');
    keysList = box.keys.toList();
    counter = keysList.last + 1 ?? 0;
    titleController = TextEditingController(text: widget.title);
    checkList = widget.contentList ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leading: BackButton(
          color: ColorConstant.secondaryColor,
        ),
        title: Text(
          widget.appBarTitle,
          style: TextStyle(
            color: ColorConstant.secondaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var box = Hive.box<ListModel>('listBox');
              if (titleController.text.isEmpty || checkList.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      titleController.text.isEmpty
                          ? 'Title is empty'
                          : 'Add atleast one item',
                    ),
                  ),
                );
              } else {
                await box.put(
                  widget.noteKey == null ? counter : widget.noteKey,
                  ListModel(
                    title: titleController.text.trim(),
                    contentList: checkList,
                    dateTime: DateTime.now(),
                  ),
                );
                keysList = box.keys.toList();
                counter = keysList.length;
                checkList = [];
                setState(() {});
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false,
                );
              }
            },
            icon: Icon(
              Icons.check_rounded,
              color: ColorConstant.secondaryColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstant.primaryColor,
                      width: 2,
                    ),
                  ),
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: ColorConstant.primaryColor,
                  ),
                ),
                controller: titleController,
                cursorColor: ColorConstant.primaryColor,
                autofocus: true,
              ),
              separatorBox,
              Expanded(
                child: StatefulBuilder(
                  builder: (context, setListState) {
                    return ListView.builder(
                      itemBuilder: (context, index) => EditListItem(
                        itemName: checkList[index],
                        onClearPressed: () {
                          checkList.removeAt(index);
                          setListState(() {});
                        },
                      ),
                      itemCount: checkList.length,
                    );
                  },
                ),
              ),
              separatorBox,
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstant.primaryColor,
                      width: 2,
                    ),
                  ),
                  labelText: 'Add to list',
                  labelStyle: TextStyle(
                    color: ColorConstant.primaryColor,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      contentController.text == ''
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Empty item',
                                ),
                                duration: Duration(
                                  milliseconds: 500,
                                ),
                              ),
                            )
                          : checkList.add(contentController.text.trim());
                      contentController.clear();
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.add_rounded,
                      size: 30,
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
                controller: contentController,
                cursorColor: ColorConstant.primaryColor,
                autofocus: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
