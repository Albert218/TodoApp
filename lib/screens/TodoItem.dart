import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_todo/model/todo.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_todo/model/db_model.dart';
import 'package:sqflite/sqflite.dart'; //to format my date

class TodoItem extends StatelessWidget {
//Create an object of database connect
var db=DatabaseConnect();


  final Todo todo;
  final onTodoChanged;
  final onDeleteItem;
  final Todo date;

   TodoItem(
      {Key? key,
      required this.todo,
      required this.onTodoChanged,
      required this.onDeleteItem,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.orangeAccent,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.todoText!,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: todo.isDone! ? TextDecoration.lineThrough : null),
            ),
            Text(
                DateFormat('dd MMM yyyy - hh:mm:aaa')
                    .format(todo.creationDate!),
                style: TextStyle(
                  fontSize: 13,
                  color: Color.fromARGB(255, 58, 58, 58),
                ))
          ],
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
