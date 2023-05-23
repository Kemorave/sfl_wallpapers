enum IncidentStatusEnum {
  newlyCreated('This is an info message'),
  assigned('This is an info message'),
  solved('This is an info message'),
  reponed('This is an info message'),
  solvedInitially('This is an info message'),
  canceled('This is an info message'),
  unkown('This is an info message'),
  ;

  final String value;

  const IncidentStatusEnum(this.value);
}
