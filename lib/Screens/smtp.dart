import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

// Use the SmtpServer class to configure an SMTP server:

String username = "verifyfotoclash@fotoclash.com";
final smtpServer = SmtpServer("smtp.hostinger.com",
    ignoreBadCertificate: true,
    username: username,
    port: 465,
    password: "SamSung@44",
    ssl: true,
    allowInsecure: true);

void verify_email(email, OTP) async {
  // Create our message.
  final message = Message()
    ..from = Address(username, "FotoClash")
    ..recipients.add(email)
    ..subject = 'Verification code for Fotoclash'
    ..text =
        "OTP for verification on the app is: $OTP\nEnter this otp in verification screen to verify.\nDo rate us\nThankyou";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print(e);
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}
