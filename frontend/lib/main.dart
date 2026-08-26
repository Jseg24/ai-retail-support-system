import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'admin_page.dart';

void main() {
  runApp(const RetailSupportApp());
}
class RetailSupportApp extends StatelessWidget{
  const RetailSupportApp({super.key});

@override
Widget build(BuildContext context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
     initialRoute: '/',
  routes: {
    '/': (context) => const TicketFormPage(),
    '/admin': (context) => const AdminPage(),
  },
  );
}
}

class TicketFormPage extends StatefulWidget{
  const TicketFormPage({super.key});

  @override
  State<TicketFormPage> createState() => _TicketFormPageState();
}

class _TicketFormPageState extends State<TicketFormPage>{
   final idController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final storeController = TextEditingController();
  final descriptionController = TextEditingController();

Future<void> submitTicket() async{
  final response = await http.post(
    Uri.parse('http://localhost:8080/api/tickets'),
    headers: {
      'Content-Type' : 'application/json',
    },
    body: jsonEncode({
      'associateId' : idController.text,
      'associateName': nameController.text,
      'associateEmail' : emailController.text,
      'storeNumber' : storeController.text,
      'description' : descriptionController.text,
      'status': 'OPEN',
  }),
  );
  if(response.statusCode == 200 || response.statusCode == 201){
    final data = jsonDecode(response.body);

    print('Ticket created successfully');
    print(data);
    
  }else{
    print('Ticket creation failed');
    print(response.statusCode);
    print(response.body);
  }
}


@override
Widget build(BuildContext context){
return Scaffold(
  appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 99, 0, 1),
    title: const Text(
      'Associate Support',
     style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 22,
  ),
  ),
  ),
body: Center(
  child: SizedBox(
  width: 600,  
  child: Padding(
  padding: const EdgeInsets.all(24),
  child: Column(
    children: [
       const Text(
            'ASSOCIATE SERVICE CENTER',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'PLEASE FILL OUT THE FORM',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              
            ),
          ),
          TextField(
        controller: idController,
        decoration: const InputDecoration(
          labelText: 'Associate Id',
        ),
      ),
      TextField(
        controller: nameController,
        decoration: const InputDecoration(
          labelText: 'Name',
        ),
      ),
      TextField(
        controller: emailController,
        decoration: const InputDecoration(
          labelText: 'Email',
        ),
      ),
      TextField(
        controller: storeController,
        decoration: const InputDecoration(
          labelText: 'Store Number',
        ),
        ),
        TextField(
          controller: descriptionController,
          maxLines: 5,
          decoration: const InputDecoration(
            labelText: 'Describe your issue',
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed:()async{
              await submitTicket();
          
              if(!context.mounted) return;
          
              showDialog(
                context: context, 
                builder: (context) => AlertDialog(
                title: Text('Ticket has been successfully submitted'),
                content: Text('Ticket is pending review. An email will be sent out shortly with an update.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ]
            ),
            
              );
            
            
            },
            child: const Text('Submit Ticket'),
          ),
        ),
        
        
    ],
    ),),
  ),
)
  );
}

}