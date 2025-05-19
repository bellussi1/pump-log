import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pump_log/components/exercise_tile.dart';
import 'package:pump_log/data/workout_data.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;

  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  //checkbox clicado
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(
      context,
      listen: false,
    ).checkOffExercise(workoutName, exerciseName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder:
          (context, value, child) => Scaffold(
            appBar: AppBar(title: Text(widget.workoutName)),
            body: ListView.builder(
              itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
              itemBuilder:
                  (context, index) => ExerciseTile(
                    exerciseName:
                        value
                            .getRelevantWorkout(widget.workoutName)
                            .exercises[index]
                            .name,
                    weight:
                        value
                            .getRelevantWorkout(widget.workoutName)
                            .exercises[index]
                            .weight,
                    sets:
                        value
                            .getRelevantWorkout(widget.workoutName)
                            .exercises[index]
                            .sets,
                    reps:
                        value
                            .getRelevantWorkout(widget.workoutName)
                            .exercises[index]
                            .reps,
                    isCompleted:
                        value
                            .getRelevantWorkout(widget.workoutName)
                            .exercises[index]
                            .isCompleted,
                    onCheckBoxChanged:
                        (val) => onCheckBoxChanged(
                          widget.workoutName,
                          value
                              .getRelevantWorkout(widget.workoutName)
                              .exercises[index]
                              .name,
                        ),
                  ),
            ),
          ),
    );
  }
}
