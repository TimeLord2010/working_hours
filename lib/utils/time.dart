const secondsPerDay = 86400;
const secondsPerHour = 3600;

int secondsToMinutes(int secs) {
  return secs ~/ 60;
}

int minutesToHours(int min) {
  return min ~/ 60;
}

int hoursToDays(int hrs) {
  return hrs ~/ 24;
}
