enum StateEnum {
  info('This is an info message'),
  success('This is a success message'),
  ready('This is a ready message'), 
  idle('idle'),
  error('This is an error message');

  final String value;

  const StateEnum(this.value);
}
