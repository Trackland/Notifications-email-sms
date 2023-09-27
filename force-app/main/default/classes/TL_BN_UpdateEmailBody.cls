public class TL_BN_UpdateEmailBody {
  @InvocableMethod(label='Send Appointment Reminder' description='Send Appointment Reminder')
  public static String[] sendClinicEmail(variables[] variablesList){
    String appointmentId = variablesList[0].appointmentId;
    EmailTemplate emailTemplate = variablesList[0].emailTemplate;
    String emailBody = emailTemplate.Body;
    ServiceAppointment appointment = [SELECT Id, ActualStartTime, Subject FROM ServiceAppointment WHERE Id = :appointmentId];
    Map<String, String> fieldMap = new Map<String, String>{
      'ActualStartDate' => appointment.ActualStartTime.format(),
      'ActualStartTime' => appointment.ActualStartTime.format('hh:mm a'),
      'Subject' => appointment.Subject
    };
    for(String key : fieldMap.keySet()) emailBody = emailBody.replace('{!ServiceAppointment.' + key + '}', fieldMap.get(key));
    return new List<String>{emailBody};
  }

  public class variables{
    @InvocableVariable(label='AppointmentId' description='Appointment Id' required=true)
    public String appointmentId;
    @InvocableVariable(label='Email Template' description='Email Template' required=true)
    public EmailTemplate emailTemplate;
  }
}