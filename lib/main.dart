import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> groceries = [];
  final textController = TextEditingController();
  List<bool> isChecked = [];
  int? groceryIndex;
  IconData buttonIcon = Icons.add;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 130,
        backgroundColor: Colors.blue,
        title: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text("Grocery List"),
            Row(
              children: [
                Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Add Item"
                      ),
                  controller: textController,
                )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (groceryIndex != null){
                          groceries[groceryIndex!]=textController.text;
                          groceryIndex = null;
                          buttonIcon = Icons.add;
                        }else {
                          groceries.add(textController.text);
                        }
                        isChecked.add(false);
                        textController.clear();
                      });
                    },
                    icon: Icon(buttonIcon)),
              ],
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: groceries.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(groceries[index]),
                  Checkbox(
                    value: isChecked[index],
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked[index] = value!;
                      });
                    },
                  ),
                ],
              ),
              onTap: () {
                groceryIndex = index;
                setState(() {
                  textController.text = groceries[index];
                  buttonIcon = Icons.change_circle_outlined;
                });
              },
              onLongPress: () {
                setState(() {
                  groceries.removeAt(index);
                  isChecked.removeAt(index); // Remove the corresponding checkbox state
                });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Colors.blue,
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  groceries.clear();
                });
              },
              icon: Icon(Icons.clear_all_sharp),
            ),
            Text("Clear List"),
          ],
        ),
      ),
    );
  }
}
