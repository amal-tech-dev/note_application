import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/controller/check_list_controller.dart';
import 'package:note_application/model/list_model.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/utils/dimen_constant.dart';
import 'package:note_application/view/edit_check_list_screen/edit_check_list_widgets/edit_check_list_item.dart';
import 'package:note_application/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class EditCheckListScreen extends StatefulWidget {
  String appBarTitle;
  String title;
  List<ContentModel>? contentList;
  int? noteKey;

  EditCheckListScreen({
    super.key,
    required this.appBarTitle,
    this.title = '',
    this.contentList,
    this.noteKey,
  });

  @override
  State<EditCheckListScreen> createState() => _EditCheckListScreenState();
}

class _EditCheckListScreenState extends State<EditCheckListScreen> {
  int counter = 0;
  List keysList = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    initialiseHive();
    titleController = TextEditingController(text: widget.title);
    Provider.of<CheckListController>(context, listen: false)
        .intialCheckList(widget.contentList ?? []);
    setState(() {});
    super.initState();
  }

  Future<void> initialiseHive() async {
    var box = Hive.box<CheckListModel>('checkListBox');
    keysList = box.keys.toList();
    counter = keysList.last + 1 ?? 0;
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
          Consumer<CheckListController>(
            builder: (context, value, child) => IconButton(
              onPressed: () async {
                var box = Hive.box<CheckListModel>('checkListBox');
                List<ContentModel> list = value.checkList;
                if (titleController.text.isEmpty || list.isEmpty) {
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
                  List<ContentModel> list = value.checkList;
                  await box.put(
                    widget.noteKey ?? counter,
                    CheckListModel(
                      title: titleController.text.trim(),
                      contentList: list,
                      dateTime: DateTime.now(),
                    ),
                  );
                  keysList = box.keys.toList();
                  counter = keysList.length;
                  value.clearContent();
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(DimenConstant.edgePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstant.primaryColor,
                    width: DimenConstant.borderWidth,
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
            DimenConstant.separator,
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
                suffixIcon: Consumer<CheckListController>(
                  builder: (context, value, child) => IconButton(
                    onPressed: () {
                      contentController.text == ''
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Empty item',
                                ),
                              ),
                            )
                          : value.addContent(contentController.text.trim());
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
              ),
              controller: contentController,
              cursorColor: ColorConstant.primaryColor,
              autofocus: true,
            ),
            DimenConstant.separator,
            Expanded(
              child: StatefulBuilder(
                builder: (context, setListState) =>
                    Consumer<CheckListController>(
                  builder: (context, value, child) => ListView.builder(
                    itemBuilder: (context, index) => EditCheckListItem(
                      itemName: value.checkList[index].item,
                      onClearPressed: () {
                        value.deleteContent(index);
                        setListState(() {});
                      },
                    ),
                    itemCount: value.checkList.length,
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
