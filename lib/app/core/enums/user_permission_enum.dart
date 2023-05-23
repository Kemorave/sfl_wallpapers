enum UserPermissionEnum {
  solveIncident('Permission.Incident.Solving'),
  createIncident('Permission.Incident.Add');

  final String value;
  const UserPermissionEnum(this.value);
}
