import '../services/email_service.dart';

//quick setup helpers for configuring email sending
//⚠️ never commit your actual passwords to git!
class EmailConfig {
  //you can uncomment this and fill in your details to enable production emails
  //but for now it just uses dev mode (prints codes to console)
  static void configureProductionEmail() {
    //uncomment and fill this in when you're ready for production:
    
    /*
    EmailService().configure(
      smtpHost: 'smtp.gmail.com',
      smtpPort: 587,
      smtpUsername: 'your-email@gmail.com',
      smtpPassword: 'your-app-password',
      fromEmail: 'noreply@ketopilot.com',
      fromName: 'KetoPilot Team',
    );
    */
  }
  
  //easy setup for Gmail (you'll need an app password, not your regular password)
  //go to Google Account > Security > App Passwords to get one
  static void configureGmail({
    required String email,
    required String appPassword,
  }) {
    EmailService().configure(
      smtpHost: 'smtp.gmail.com',
      smtpPort: 587,
      smtpUsername: email,
      smtpPassword: appPassword,
      fromEmail: email,
      fromName: 'KetoPilot',
    );
  }
  
  //for production apps, SendGrid is usually better than Gmail
  //sign up at sendgrid.com and grab an API key
  static void configureSendGrid({
    required String apiKey,
    required String fromEmail,
  }) {
    EmailService().configure(
      smtpHost: 'smtp.sendgrid.net',
      smtpPort: 587,
      smtpUsername: 'apikey',
      smtpPassword: apiKey,
      fromEmail: fromEmail,
      fromName: 'KetoPilot',
    );
  }
}
