import 'package:flutter/material.dart';
import 'package:hptracker_flutter/ui/home/home_viewmodel.dart';

class NewcharacterformView extends StatefulWidget {
  const NewcharacterformView({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<NewcharacterformView> createState() => _NewcharacterformViewState();
}

class _NewcharacterformViewState extends State<NewcharacterformView> {
  final _formKey = GlobalKey<FormState>();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await widget.viewModel.saveNewCharacter();

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        final isLoading = widget.viewModel.isLoading;

        return AlertDialog(
          title: const Text('New Character'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Create new character'),
                Row(
                  children: [
                    Text("Name: "),
                    SizedBox(width: 15),
                    Expanded(
                      child: TextFormField(
                        controller: widget.viewModel.nameTextController,
                        focusNode: widget.viewModel.nameFocusNode,
                        decoration: const InputDecoration(
                          hintText: "Enter Name...",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text('Max HP: '),
                    SizedBox(width: 15),
                    SizedBox(
                      width: 60,
                      child: TextFormField(
                        controller: widget.viewModel.maxHpTextController,
                        focusNode: widget.viewModel.maxHpFocusNode,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: '0',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text('Max Temp HP: '),
                    SizedBox(width: 15),
                    SizedBox(
                      width: 60,
                      child: TextFormField(
                        controller: widget.viewModel.maxTempHpTextController,
                        focusNode: widget.viewModel.maxTempHpFocusNode,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: '0',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text('Max Hit Dice: '),
                    SizedBox(width: 15),
                    SizedBox(
                      width: 60,
                      child: TextFormField(
                        controller: widget.viewModel.maxHitDiceTextController,
                        focusNode: widget.viewModel.maxHitDiceFocusNode,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: '0',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: isLoading
                  ? null
                  : () {
                      widget.viewModel.nameTextController.clear();
                      widget.viewModel.maxHpTextController.clear();
                      widget.viewModel.maxTempHpTextController.clear();
                      widget.viewModel.maxHitDiceTextController.clear();
                      Navigator.of(context).pop();
                    },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: isLoading ? null : _submitForm,
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
