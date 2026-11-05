import 'dart:convert';
import 'config/api_config.dart';
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
static const bool publicDemo = true;

  @override
  void initState() {
    super.initState();
    getTickets();
  }



  Future<void> getTickets() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/api/tickets'),
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

Future<void> deleteTicket(int id) async {
  print('deleteTicket called for id: $id');
  final response = await http.delete(
    Uri.parse('${ApiConfig.baseUrl}/api/tickets/$id/delete'),
  );

  print('DELETE STATUS: ${response.statusCode}');
  print('Deleting ticket id: $id');

  if (response.statusCode == 200 || response.statusCode == 204) {
    setState(() {
      print('Before delete: ${tickets.length}');

      tickets.removeWhere(
        (ticket) => ticket['id'] == id,
      );

      print('After delete: ${tickets.length}');
    });
  } else {
    print('Failed to delete ticket');
    print(response.statusCode);
    print(response.body);
  }
}

  Future<void> approveTicket(int id) async {
    final response = await http.patch(
      Uri.parse('${ApiConfig.baseUrl}/api/tickets/$id/approve'),
    );
    if (response.statusCode == 200) {
      setState(() {
        final index = tickets.indexWhere((ticket) => ticket['id'] == id);
        
        if (index != -1) {
          tickets[index]['status'] = 'APPROVED';
        }
      });
    } else {
      print('Failed to approve ticket:');
      print(response.statusCode);
    }
  }

  Future<void> rejectTicket(int id) async {
    final response = await http.patch(
      Uri.parse('${ApiConfig.baseUrl}/api/tickets/$id/reject'),
    );
    if (response.statusCode == 200) {
      setState(() {
        final index = tickets.indexWhere((ticket) => ticket['id'] == id);
        if (index != -1) {
          tickets[index]['status'] = 'REJECTED';
        }
      });
    } else {
      print('Failed to reject ticket');
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 99, 0, 1),
       title: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Text(
      'Admin Ticket Review',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    if (publicDemo)
      const Text(
        'Public Demo — Administrative Actions are Disabled.',
        style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 12, 
          
          fontWeight: FontWeight.bold,
        ),
      ),
  ],
),
      ),
      body: isLoading
      
          ? const Center(child: CircularProgressIndicator())
          
          : ListView.builder(
            
            
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                    
                  ),
                  
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text(
                          'Ticket #${ticket['id']} - #${ticket['storeNumber'] ?? 'Unknown'} - (${ticket['status']})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          'Associate ID: ${ticket['associateId'] ?? 'Unknown'}\n'
                          'Status: ${ticket['status']}\n'
                          'Category: ${ticket['category'] ?? 'Pending'}\n'
                          'Priority: ${ticket['priority'] ?? 'Pending'}\n'
                          'Description: ${ticket['description']}\n'
                          'AI Response: ${ticket['aiResponse'] ?? 'Pending'}',
                        ),

                        const SizedBox(height: 12),
                        if (ticket['status'] == 'PENDING_REVIEW')
                          Row(
                            children: [
                              ElevatedButton(
  onPressed: publicDemo
      ? null
      : () => approveTicket(ticket['id']),
  child: const Text('Approve'),
),
                              const SizedBox(width: 12),

                             ElevatedButton(
  onPressed: publicDemo
      ? null
      :() => rejectTicket(ticket['id']),
  child: const Text('Reject'),
)
                              
                            ],
                          ),
                          const SizedBox(height: 12),
                          if(ticket['status'] == 'REJECTED' && !publicDemo)
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context, 
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Ticket'),
                                    content: const Text('Are you sure you want to permanently delete this rejected ticket?'),
                                  
                                    actions: [
                                      ElevatedButton(
  onPressed: publicDemo
      ? null
      :() => deleteTicket(ticket['id']),
  child: const Text('Delete'),
),
                                      TextButton(
                                        onPressed: ()=>
                                          Navigator.pop(context),
                                         
                                        
                                        child: const Text('Cancel'),
                                    
                                  ),
                                    ] ,
                                  ),
                                  );
                                
                              }, child: const Text('Delete'),
                            ),

                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
