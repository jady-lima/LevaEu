import 'package:flutter/material.dart';
import 'package:levaeu_mobile/screens/navigation/new_races/map_screen.dart';

class CreateNewRace extends StatefulWidget {
  const CreateNewRace({super.key});

  @override
  _CreateNewRaceState createState() => _CreateNewRaceState();
}

class _CreateNewRaceState extends State<CreateNewRace> {
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _departureController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _confirmCreation() {
    // Lógica para confirmar a criação da corrida
    print("Saída: ${_departureController.text}");
    print("Destino: ${_destinationController.text}");
    print("Horário: ${_selectedTime?.format(context)}");
  }

  void _selectLocation(String type) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MapScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        if (type == 'departure') {
          _departureController.text = result;
        } else if (type == 'destination') {
          _destinationController.text = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Nova Corrida'),
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _departureController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Saída',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.location_on),
                  onPressed: () => _selectLocation('departure'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _destinationController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Destino',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.location_on),
                  onPressed: () => _selectLocation('destination'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedTime == null
                        ? 'Selecione o horário'
                        : 'Horário: ${_selectedTime?.format(context)}',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () => _selectTime(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _confirmCreation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
