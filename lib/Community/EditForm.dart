import 'package:flutter/material.dart';

class EditForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final VoidCallback onSave;
  final String formType;

  const EditForm({
    Key? key,
    required this.titleController,
    required this.contentController,
    required this.onSave,
    required this.formType,
  }) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formType == 'post' ? 'Edit Post' : 'Edit Comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.formType == 'post')
              TextField(
                controller: widget.titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
            SizedBox(height: 16),
            TextField(
              controller: widget.contentController,
              decoration: InputDecoration(
                labelText: widget.formType == 'post' ? 'Content' : 'Edit Comment',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {            
                widget.onSave();
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}