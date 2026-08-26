import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<dynamic> tickets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getTickets();
  }

  Future<void> getTickets() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/api/tickets'),
    );

    if (response.statusCode == 200) {
      setState(() {
        tickets = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });

      print('Failed to retrieve tickets');
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 99, 0, 1),
        title: const Text(
          'Admin Ticket Review',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      'Ticket #${ticket['id']} - ${ticket['associateName'] ?? 'Unknown'}',
                    ),
                    subtitle: Text(
                      'Store: ${ticket['storeNumber']}\n'
                      'Status: ${ticket['status']}\n'
                      '${ticket['description']}',
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}