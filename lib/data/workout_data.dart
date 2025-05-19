import 'package:flutter/material.dart';
import 'package:pump_log/models/exercise.dart';
import 'package:pump_log/models/workout.dart';

class WorkoutData extends ChangeNotifier {
  List<Workout> workoutList = [
    Workout(
      name: "Upper Body",
      exercise: [
        Exercise(name: "Biceps Curl", weight: "10", reps: "10", sets: "3"),
      ],
    ),
    Workout(
      name: "Lower Body",
      exercise: [
        Exercise(name: "Leg Extension", weight: "10", reps: "10", sets: "3"),
      ],
    ),
  ];

  // Lista todos os treinos
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // tamanho do treino
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    return relevantWorkout.exercise.length;
  }

  // adiciona treinos
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercise: []));

    notifyListeners();
  }

  // adiciona exercicios
  void addExercise(
    String workoutName,
    String exerciseName,
    String weight,
    String reps,
    String sets,
  ) {
    // define o treino relevante
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercise.add(
      Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets),
    );

    notifyListeners();
  }

  void checkOffExercise(String workoutName, String exerciseName) {
    // define o exercicio relevante
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
  }

  // retorna objeto de treino, dando um nome de treino
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout = workoutList.firstWhere(
      (workout) => workout.name == workoutName,
    );

    return relevantWorkout;
  }

  // retorna objeto de treino, dando um nome de treino + nome de exercicio
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    Exercise relevantExercise = relevantWorkout.exercise.firstWhere(
      (exercise) => exercise.name == exerciseName,
    );

    return relevantExercise;
  }
}
