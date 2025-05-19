import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pump_log/data/workout_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newWorkoutNameController = TextEditingController();

  void createNewWorkout() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Criar novo treino'),
            content: TextField(controller: newWorkoutNameController),
            actions: [
              //salvar
              MaterialButton(onPressed: save, child: Text('Salvar')),

              //cancelar
              MaterialButton(onPressed: cancel, child: Text('Cancelar')),
            ],
          ),
    );
  }

  // salvar treino
  void save() {
    // pega o nome do treino pelo texto do controller
    String newWorkoutname = newWorkoutNameController.text;
    // adiciona o texto para a lista de treino
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutname);

    //fechar depois de salvar
    Navigator.pop(context);
    clear();
  }

  // cancelar treino
  void cancel() {
    //fechar depois de cancelar
    Navigator.pop(context);
    clear();
  }

  // limpa o controller
  void clear() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder:
          (context, value, child) => Scaffold(
            appBar: AppBar(title: const Text('Pump Log')),
            floatingActionButton: FloatingActionButton(
              onPressed: createNewWorkout,
              child: const Icon(Icons.add),
            ),
            body: ListView.builder(
              itemCount: value.getWorkoutList().length,
              itemBuilder:
                  (context, index) =>
                      ListTile(title: Text(value.getWorkoutList()[index].name)),
            ),
          ),
    );
  }
}
