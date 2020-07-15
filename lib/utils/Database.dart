import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:ToDoApp/models/tasks.dart';



class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }
  

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "toDo.db"),
        onCreate: (db, version) async {
          
      await db.execute(""" 
          CREATE TABLE tasks (

            taskName TEXT PRIMARY KEY,
            isDated bool,
            isScheduled bool,
            date TEXT,
            time TEXT,
            listName TEXT,
            listColor TEXT,
            isDone bool
          )    
          """);

      await db.execute(""" 

          CREATE TABLE lists (
            listName TEXT PRIMARY KEY,
            listColor TEXT,
            itemCount INTEGER,
            isSelectedOnCreateScreen BOOLEAN
          )
          """);

      await db.rawInsert(
        """INSERT INTO lists(listName,listColor,itemCount,isSelectedOnCreateScreen) 
      VALUES(?,?,?,?)""" ,["School" , "Color(0xff22a1d4)" , 0, false]);
    
      await db.rawInsert(
        """INSERT INTO lists (listName,listColor,itemCount,isSelectedOnCreateScreen) 
      VALUES(?,?,?,?)""" ,["Work" , "Color(0xfff29a0c)" , 0, false]);

      await db.rawInsert(
        """INSERT INTO lists (listName,listColor,itemCount,isSelectedOnCreateScreen) 
      VALUES(?,?,?,?)""" ,["Home" , "Color(0xffe7f20c)" , 0, false]);

      await db.rawInsert(
        """INSERT INTO lists (listName,listColor,itemCount,isSelectedOnCreateScreen) 
      VALUES(?,?,?,?)""" ,["Relationship" , "Color(0xffc92a9c)" , 0, false]);

      await db.rawInsert(
        """INSERT INTO lists (listName,listColor,itemCount,isSelectedOnCreateScreen) 
      VALUES(?,?,?,?)""" ,["Shopping" , "Color(0xff050505)" , 0, false]);
    
      await db.rawInsert(
        """INSERT INTO lists (listName,listColor,itemCount,isSelectedOnCreateScreen) 
      VALUES(?,?,?,?)""" ,["Self Learning" , "Color(0xff20c723)" , 0, false]);
  
      
    }, version: 1);

  }

  // Yeni task ekler.
  addNewTask(Task newtask) async {
    final db = await database;
    
    var res = await db.rawInsert(""" 
      INSERT INTO tasks (taskName,isDated,isScheduled,date,time,listName,listColor,isDone) 
      VALUES(?,?,?,?,?,?,?,?)
    """, [
      newtask.taskName,
      newtask.isDated,
      newtask.isScheduled,
      newtask.date,
      newtask.time,
      newtask.listName,
      newtask.listColor,
      newtask.isDone
    ]);

    return res;
  }

  //Bugünün tasklarını verir.
  Future<dynamic> getTasksOfToday() async {
    final db = await database;

    DateTime now = new DateTime.now();
    DateTime today = DateTime(now.year,now.month,now.day);

    var res = await db.rawQuery(""" 
      SELECT * FROM tasks
      WHERE date = ? """ , [today.toString().substring(0,10)]);

    
  
    if (res.length == 0) {
      return null;

    } else {
      return res;
    }
  }

  //Yarının tasklarını verir.
  Future<dynamic> getTasksOfTomorrow() async {
    final db = await database;

    DateTime now = new DateTime.now();
    DateTime tomorrow = DateTime(now.year,now.month,now.day+1);

    var res = await db.rawQuery(""" 
      SELECT * FROM tasks
      WHERE date = ? """ , [tomorrow.toString().substring(0,10)]);

    if (res.length == 0) {
      return null;

    } else {
      return res;
    }
  }

  //Bu haftanın tasklarını verir.
  Future<dynamic> getTasksOfThisWeek() async {
    final db = await database;

    DateTime now = new DateTime.now();
    DateTime aweeklater = DateTime(now.year,now.month,now.day+7);

    var res = await db.rawQuery(""" 
      SELECT * FROM tasks
      WHERE date < ? """ , [aweeklater.toString().substring(0,10)]);

    if (res.length == 0) {
      return null;

    } else {
      return res;
    }
  }

  //Daha ilerisinin tasklarını verir.
  Future<dynamic> getTasksOfFurther() async {
    final db = await database;

    DateTime now = new DateTime.now();
    DateTime further = DateTime(now.year,now.month,now.day+7);

    var res = await db.rawQuery(""" 
      SELECT * FROM tasks
      WHERE date > ? """ , [further.toString().substring(0,10)]);

    

    if (res.length == 0) {
      return null;

    } else {
      return res;
    }
  }

  // Listeleri verir.
  Future<dynamic> getLists() async {
    final db = await database;

    var res = await db.query("lists");

    if (res.length == 0) {
      return null;
    } else {
      return res;
    }

  
  }

  // Seçili listeye ait taskları görüntüler
  Future<dynamic> getTasksOfspecificList(listName) async {
    final db = await database;

    var res = await db.rawQuery("""
    SELECT * FROM tasks
    WHERE listName = ?     """,[listName]);

    if (res.length == 0) {
      return null;
    } else {
      return res;
    }
  }


  // Taskları siler (inaktif)
  void truncateTasks() async {
    final db = await database;
    await db.execute("""DELETE FROM tasks;""");
  }

  // Listeleri siler (inaktif)
  void truncateLists() async {
    final db = await database;
    await db.execute("""DELETE FROM lists;""");
  }

  // Taskın eklendiği listenin item sayısını arttırır.
  void increaseItemCount(listName) async {
    final db = await database;
    await db.rawUpdate("""
    UPDATE lists
    SET itemCount = itemCount + 1
    WHERE listName == ?
    
    """,[listName]);

  }

  // Taskın ekleneceği listeyi seçer..
  void selectaList(listName) async {
    final db = await database;
    await db.rawUpdate("""
    UPDATE lists
    SET isSelectedOnCreateScreen = 1
    WHERE listName = ?;
    
    """ , [listName]);

  
  await db.rawUpdate("""
    UPDATE lists
    SET isSelectedOnCreateScreen = 0
    WHERE listName != ?;
    
    """, [listName]);

    
  }

  // İtem ekledikten sonra seçili listeyi tekrar seçilmemiş hale getirir.
  void reFalseAllList() async {
    final db = await database;
    await db.rawUpdate("""
    UPDATE lists
    SET isSelectedOnCreateScreen = 0
     
    """);}


  // Taskın yapılıp yapılmadığını kaydeder.
  void changeisDoneStatus(taskName,value) async {
  final db = await database;
  await db.rawUpdate("""
  UPDATE tasks
  SET isDone = ?
  WHERE taskName = ?
  """,[value,taskName]);

  }





}