/* This class contains a Map with the specifications of the different targets 
Key: Target (level)
Value: List of int representing the target for each category (in order: steps, calories, cardio, sleep)
*/

class Target {
  Map<String, List> targets = {
    // STEPS, CALORIES, CARDIO, SLEEP
    'None': [8000, 400, 10, 7],
    'Basic': [10000, 600, 10, 7],
    'Medium': [12000, 800, 15, 7],
    'Advanced': [15000, 1000, 20, 7]
  };
}
