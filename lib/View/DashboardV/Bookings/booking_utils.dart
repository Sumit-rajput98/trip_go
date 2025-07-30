String getMonthName(int month) {
  const months = [
    '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return months[month];
}

String formatDate(String? rawDate) {
  if (rawDate == null) return '';
  try {
    final date = DateTime.parse(rawDate);
    return '${date.day.toString().padLeft(2, '0')} '
        '${getMonthName(date.month)} ${date.year}';
  } catch (e) {
    return rawDate;
  }
}

String formatTime(String? dateTimeStr) {
  if (dateTimeStr == null) return 'N/A';
  try {
    final dt = DateTime.parse(dateTimeStr);
    final hour = dt.hour;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12 ? hour - 12 : hour;
    return '$hour12:$minute $period';
  } catch (e) {
    return 'N/A';
  }
}

String getBookingStatusText(int? status) {
  switch (status) {
    case 0: return "Cancelled";
    case 1: return "Completed";
    case 2: return "Confirmed";
    case 3: return "Unsuccessful";
    default: return "Unknown";
  }
}
