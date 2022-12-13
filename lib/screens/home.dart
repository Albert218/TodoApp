import 'package:flutter/material.dart';
import 'package:flutter_application_todo/screens/TodoItem.dart';
import 'package:flutter_application_todo/model/todo.dart';

class LetDoIt extends StatefulWidget {
  LetDoIt({Key? key}) : super(key: key);

  @override
  State<LetDoIt> createState() => _LetDoItState();
}

class _LetDoItState extends State<LetDoIt> {
  final todosList = Todo.todoList();
  List<Todo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    // To search in an array
    _foundTodo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: _buildApp(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(children: [
              SearchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 40, bottom: 20),
                      child: Text(
                        'All To Dos',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    for (Todo todo in _foundTodo.reversed)
                      TodoItem(
                        todo: todo,
                        
                        onTodoChanged: handleToDoChange,
                        onDeleteItem: DeleteTodoItem, date: todo,
                      ),
                  ],
                ),
              )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: 'Add new todo item',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                    onPressed: () {
                      addTodoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      minimumSize: Size(55, 55),
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void handleToDoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void DeleteTodoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void addTodoItem(String toDo) {
    setState(() {
      todosList.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo, creationDate: DateTime.now()));
    });

    _todoController.clear();
  }

  void runFilter(String enteredKeyboard) {
    List<Todo> results = [];
    if (enteredKeyboard.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyboard.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTodo=results;
    });
  }

  Widget SearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(fontSize: 20, color: Colors.grey)),
      ),
    );
  }

  AppBar _buildApp() {
    return AppBar(
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/one.jpg')),
          )
        ],
      ),
      backgroundColor: Colors.green,
    );
  }
}
