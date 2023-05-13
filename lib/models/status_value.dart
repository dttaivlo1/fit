/// Represents a status value for a particular period during a countdown
class StatusValue {
  final String status;

  StatusValue.isWorking() : status = 'work';
  StatusValue.isResting() : status = 'rest';
  StatusValue.isBreak() : status = 'break';
  StatusValue.isPreparing() : status = 'prepare'; // Prior to first work rep
  StatusValue.isComplete() : status = 'complete';
}
