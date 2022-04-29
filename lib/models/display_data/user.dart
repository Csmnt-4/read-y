class UserDisplayData {
  int id;
  String name;
  Map<String, String> stats;
  String avatar;

  UserDisplayData(
    this.id,
    this.name,
    this.stats,
    this.avatar,
  );

  Map<String, String> statValues = {
    'Read': 'Прочитано',
    'Comments' : 'Комментариев',
  };

  updateStats(){
    Map<String, String> newStats = {
      'read' : '',
      'comments' : '',
    };

    stats = newStats;
  }
}