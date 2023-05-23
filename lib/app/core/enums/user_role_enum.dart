enum UserRoleEnum {
  incidentEmployee('IncidentEmployee'),
  supervisor('Supervisors'),
  employee('Employees'),
  mqawel('Mqawel'),
  manager('Managers');

  final String value;
  const UserRoleEnum(this.value);
}
