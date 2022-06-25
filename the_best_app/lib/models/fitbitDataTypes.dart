class SleepData {
  final int sleepHours;

  SleepData(this.sleepHours);
}

class ActivityData {
  final int calories;
  ActivityData(this.calories);
}

// TABLE STRUCTURE
//     Table Name : Steps Data
// ID(int) Data dei passi(date) Numero passi(int)

class StepsData {
  final int steps;
  StepsData(this.steps);
}

// TABLE STRUCTURE
//     Table Name : Heart Data
// ID(int) Data dell'attivià(date) Minuti in fascia cardio(int)

class HeartData {
  final int cardio;
  HeartData(this.cardio);
}
