import 'package:flutter/material.dart';

class TesteRadioList extends StatefulWidget {
  @override
  _TesteRadioListState createState() => _TesteRadioListState();
}

class _TesteRadioListState extends State<TesteRadioList> {
  List<User> users;
  User selectedUser;
  bool checkSelect = false;

  @override
  void initState() {
    super.initState();
    users = User.getUsers();
  }

  onSelected(bool selected, User user) {
    if (selected == true) {
      setState(() {
        users.add(user);
      });
    } else {
      setState(() {
        users.remove(user);
      });
    }
  }

  setSelectedUser(User user) {
    setState(() {
      selectedUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RadioListTitle"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              RaisedButton(
                child: Text("RadioList"),
                onPressed: () {
                  testeRadioList();
                },
              ),
              RaisedButton(
                child: Text("CheckBox"),
                onPressed: () {
                  testeCheckBoxList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  testeRadioList() {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Teste dialog"),
              content: Container(
                width: 300.0,
                child: ListView(
                  children: users.map((u) {
                    return RadioListTile<User>(
                      value: u,
                      groupValue: selectedUser,
                      title: Text(u.firstName),
                      subtitle: Text(u.lastName),
                      selected: selectedUser == u,
                      activeColor: Colors.green,
                      autofocus: true,
                      toggleable: true,
                      secondary: Icon(Icons.select_all_outlined),
                      onChanged: (valor) {
                        setState(() {
                          setSelectedUser(valor);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  testeCheckBoxList() {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Teste checkBox"),
              content: Container(
                width: 300.0,
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    User u = users[index];
                    return CheckboxListTile(
                      value: users.contains(users[index]),
                      title: Text(u.firstName),
                      subtitle: Text(u.lastName),
                      activeColor: Colors.green,
                      onChanged: (bool valor) {
                        checkSelect = valor;
                        onSelected(checkSelect, u);
                        print("Clicado: ${checkSelect} - ${u.firstName}");
                        for (User s in users) {
                          print("Lista: ${s.firstName}");
                        }
                      },
                    );
                  },
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class User {
  int userId;
  String firstName;
  String lastName;

  User({this.userId, this.firstName, this.lastName});

  static List<User> getUsers() {
    return <User>[
      User(userId: 1, firstName: "Aaron", lastName: "Jackson"),
      User(userId: 2, firstName: "Ben", lastName: "John"),
      User(userId: 3, firstName: "Carrie", lastName: "Brown"),
      User(userId: 4, firstName: "Deep", lastName: "Sen"),
      User(userId: 5, firstName: "Emily", lastName: "Jane"),
      User(userId: 6, firstName: "Aaron", lastName: "Jackson"),
    ];
  }
}
