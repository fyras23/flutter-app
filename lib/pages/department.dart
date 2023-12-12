import 'package:client/models/department_model.dart';
import 'package:client/pages/attendance.dart';
import 'package:client/pages/class.dart';
import 'package:client/pages/department_class.dart';
import 'package:client/pages/home.dart';
import 'package:client/pages/subject.dart';
import 'package:client/services/department_service.dart';
import 'package:flutter/material.dart';

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({super.key});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  Future<List<Department>> _departments = getDepartments();

  void fetchDepartments() {
    setState(() {
      _departments = getDepartments();
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _updateNameController = TextEditingController();
  final TextEditingController _updateDescriptionController =
      TextEditingController();

  void _showUpdateDialog(Department department) {
    _updateNameController.text = department.name;
    _updateDescriptionController.text = department.description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: const Text('Update department'),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _updateNameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  controller: _updateDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
              style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      Color.fromARGB(255, 255, 0, 0),
    ),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set text color to white
  ),
            ),
            TextButton(
              onPressed: () {
                final Department department = Department(
                    name: _updateNameController.text,
                    description: _updateDescriptionController.text);
                updateDepartment(department);
                Navigator.pop(context);
                SnackBar snackBar = SnackBar(
                  content: Text('${_updateNameController.text} updated'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                fetchDepartments();
              },
              child: const Text('Update'),
              style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      Color.fromARGB(255, 255, 0, 0),
    ),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set text color to white
  ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ISET',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 0, 0),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color.fromARGB(255, 255, 0, 0),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 0, 0),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Manage students'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            ListTile(
              title: const Text('Manage classes'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ClassPage()));
              },
            ),
            ListTile(
              title: const Text('Manage departments'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DepartmentPage()));
              },
            ),
            ListTile(
              title: const Text('Manage subjects'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SubjectPage()));
              },
            ),
            ListTile(
              title: const Text('Manage attendances'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AttendancePage()));
              },
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Manage departments',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            title: const Text('Add department'),
                            content: SizedBox(
                              width: 300,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                    ),
                                  ),
                                  TextField(
                                    controller: _descriptionController,
                                    decoration: const InputDecoration(
                                      labelText: 'Description',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                                style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      Color.fromARGB(255, 255, 0, 0),
    ),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set text color to white
  ),
                              ),
                              TextButton(
                                onPressed: () {
                                  final Department department = Department(
                                      name: _nameController.text,
                                      description: _descriptionController.text);
                                  createDepartment(department);
                                  Navigator.pop(context);
                                  SnackBar snackBar = SnackBar(
                                    content:
                                        Text('${_nameController.text} added'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  fetchDepartments();
                                },
                                child: const Text('Add'),
                                style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      Color.fromARGB(255, 255, 0, 0),
    ),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set text color to white
  ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Add department'),
                    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      Color.fromARGB(255, 255, 0, 0),
    ),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set text color to white
  ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      fetchDepartments();
                    },
                    
                    child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.refresh, color: Colors.white), // Add refresh icon
      const SizedBox(width: 8.0), // Add some space between icon and text
      const Text('Refresh'),
      
    ],
    
  ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Department>>(
                future: _departments,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DepartmentClassesPage(
                                  department: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                          title: Text(snapshot.data![index].name.toString()),
                          subtitle: Text(
                              snapshot.data![index].description.toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _showUpdateDialog(snapshot.data![index]);
                                },
                                icon: const Icon(Icons.edit),
                                style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      Color.fromARGB(255, 255, 0, 0),
    ),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set text color to white
  ),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteDepartment(snapshot.data![index].id!);
                                  SnackBar snackBar = SnackBar(
                                    content: Text(
                                        '${snapshot.data![index].name} deleted'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  fetchDepartments();
                                },
                                icon: const Icon(Icons.delete),
                                style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      Color.fromARGB(255, 255, 0, 0),
    ),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set text color to white
  ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
