import 'package:flutter/material.dart';
import 'package:crud/user_services.dart';
import 'package:crud/user_type.dart';

class UserDataTable extends StatefulWidget {
  //
  UserDataTable() : super();

  final String title = 'User Data Table';

  @override
  _UserDataTableState createState() => _UserDataTableState();
}

class _UserDataTableState extends State<UserDataTable> {
  List<User> _user;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // controller for the First Name TextField we are going to create.
  TextEditingController _firstNameController;
  // controller for the Last Name TextField we are going to create.
  TextEditingController _lastNameController;
  User _selectedEmployee;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _user = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _getUsers();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('Success' == result) {
        // Table is created successfully.
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }

  // Now lets add an Employee
  _addUser() {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding User...');
    Services.addUser(_firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('Success' == result) {
        _getUsers(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
  }

  _getUsers() {
    _showProgress('Loading Users...');
    Services.getUsers().then((u) {
      setState(() {
        _user = u;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${u.length}");
    });
  }

  _updateUser(User u) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating User...');
    Services.updateUser(
            u.id, _firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('Success' == result) {
        _getUsers(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      } else
        print(result);
    });
  }

  _deleteUser(User u) {
    _showProgress('Deleting Employee...');
    Services.deleteUser(u.id).then((result) {
      if ('Success' == result) {
        _getUsers(); // Refresh after delete...
      }
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _firstNameController.clear();
    _lastNameController.clear();
  }

  _showValues(User u) {
    _firstNameController.text = u.firstName;
    _lastNameController.text = u.lastName;
  }

  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          horizontalMargin: 5.0,
          columns: [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('FIRST NAME'),
            ),
            DataColumn(
              label: Text('LAST NAME'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: _user
                  ?.map(
                    (u) => DataRow(cells: [
                      DataCell(
                        Text(u.id.toString()),
                        // Add tap in the row and populate the
                        // textfields with the corresponding values to update
                        onTap: () {
                          _showValues(u);
                          // Set the Selected employee to Update
                          _selectedEmployee = u;
                          setState(() {
                            _isUpdating = true;
                          });
                        },
                      ),
                      DataCell(
                        Text(
                          u.firstName.toUpperCase(),
                        ),
                        onTap: () {
                          _showValues(u);
                          // Set the Selected employee to Update
                          _selectedEmployee = u;
                          // Set flag updating to true to indicate in Update Mode
                          setState(() {
                            _isUpdating = true;
                          });
                        },
                      ),
                      DataCell(
                        Text(
                          u.lastName.toUpperCase(),
                        ),
                        onTap: () {
                          _showValues(u);
                          // Set the Selected employee to Update
                          _selectedEmployee = u;
                          setState(() {
                            _isUpdating = true;
                          });
                        },
                      ),
                      DataCell(IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteUser(u);
                        },
                      ))
                    ]),
                  )
                  ?.toList() ??
              [],
        ),
      ),
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getUsers();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _firstNameController,
                style: style,
                decoration: InputDecoration.collapsed(
                  hintText: 'First Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                textAlign: TextAlign.center,
                style: style,
                controller: _lastNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Last Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            ),
            // Add an update button and a Cancel Button
            // show these buttons only when updating an employee
            _isUpdating
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        elevation: 10.0,
                        color: Colors.blueGrey,
                        child: Text(
                          'UPDATE',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          _updateUser(_selectedEmployee);
                        },
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      OutlineButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          setState(() {
                            _isUpdating = false;
                          });
                          _clearValues();
                        },
                      ),
                    ],
                  )
                : Container(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addUser();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
