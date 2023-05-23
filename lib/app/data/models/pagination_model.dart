class PaginationModel {
  int? page;
  int? perPage;
  int? totalResults;
  String? nextPage;
  String? prevPage;

  PaginationModel(
      {this.page,
      this.perPage,
      this.totalResults,
      this.nextPage,
      this.prevPage});

  PaginationModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    totalResults = json['total_results'];
    nextPage = json['next_page'];
    prevPage = json['prev_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total_results'] = this.totalResults;
    data['next_page'] = this.nextPage;
    data['prev_page'] = this.prevPage;
    return data;
  }
}
