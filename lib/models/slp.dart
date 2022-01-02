class SlpStats {
  int total;
  int claimableTotal;
  DateTime? lastClaimedItemAt;
  int todaySoFar;
  int yesterdaySLP;
  int average;

  SlpStats({
    required this.total,
    required this.claimableTotal,
    required this.todaySoFar,
    required this.yesterdaySLP,
    required this.average,
  });

  SlpStats.fromJson(Map<String, dynamic> json)
      : total = json['total'],
        claimableTotal = json['claimableTotal'],
        lastClaimedItemAt = json['lastClaimedItemAt'] != 0
            ? DateTime.fromMillisecondsSinceEpoch(
                    json['lastClaimedItemAt'] * 1000)
                .toUtc()
                .toLocal()
            : null,
        todaySoFar = json['todaySoFar'] ?? 0,
        yesterdaySLP = json['yesterdaySLP'] ?? 0,
        average = json['average'] ?? 0;
}
