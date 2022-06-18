// import 'package:flutter/material.dart';

// class Terms extends StatelessWidget {
//   const Terms({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Terms and Conditions ",
//                   style: TextStyle(fontSize: 25),
//                 ),
//                 const Text("Home/ Terms and Conditons "),
//                 const SizedBox(height: 25),
//                 const Text(
//                   "These terms and conditions of use (“Terms of Use/Service”) along with other policies available on our platform forms a legally binding agreement between You and SHAAN Tech Solutions Pvt. Ltd. (“FOTOCLASH”, “Our”, “We”, “Us”).",
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "PLEASE READ THESE TERMS OF USE CAREFULLY BEFORE PLAYING ANY CONTEST OR/AND USING THE FOTOCLASH PLATFORM.\nIf You do not agree with any of the Terms of Use/Service or/and Privacy Policy, kindly refrain from using Our services offered through the FotoClash Platform."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "We have tried Our best to simplify the Terms of Use for your understanding, but We understand that it is a lengthy document. So, We have summarised some of the essentials clauses at the beginning, and provided links(if needed) there that should take You to the relevant clause where You can find more details. We want You to know that the Summary only encapsulates the key aspects of that clause and not the entire clause itself. So, please refer to the details of the clauses for a complete understanding."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "1. You may start using Our web portal https://www.fotoclash.com/ , partner websites, mobile applications and other portals (collectively, the 'Platform') only after you have agreed to abide by the terms and conditions that have been laid down in this Agreement. Please refer to the Introduction section, to get a better understanding of the meaning of the various words used in this Terms of Use agreement, and how they may be updated."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "2. A person of sound mind, who is above 18 years of age, may use this Platform."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "3. The Platform may not be used by residents of Kerala, Tamil Nadu, Assam, Odisha, Nagaland, Sikkim, Andhara Pradesh and Telangana. In addition to this, certain Contests /application or anything related to our PLATFORM may be restricted in some additional states. Visit our Eligibility section for more information on who may use the platform."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "4. The steps to register on the platform & add money to Your account have been detailed out under Our Nature and use of the Platform section."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "5. Certain games may have pre-determined outcomes and these outcomes are achievable by users using their skills. "),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 const Text(
//                   "6. Please note that Your User Details like your username and profile picture will be visible to other users on the Platform.",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "7. Your ability to participate in the Contests available on Our Platform are governed by rules that you can read more about in Our Contests. Participation section. It is possible that each Contests may be subject to its own Rules and Code of Conduct. To understand this better please refer further."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "8. Please note that the sole discretion to determine the terms applicable on any Contest including the Awards to be given in any Contest lies with Us. Further, the Entry Fee for any Contest is non-refundable and may only be refunded under the circumstances stated in Our Return, Refund and Cancellation policy."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "9. Winnings in Your account may be withdrawn by You, subject to the completion of KYC verification and will be subject to TDS deductions when applicable."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "10. Our Platform offers only skill-based photographers, models, or who have skills in photoshoot, photography or related to it. To understand more about the nature of Contests offered on Our Platform please refer to the Contests of skill section."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "11. We would also request you to go through our Safety Section to be aware of and follow all the necessary precautions while playing Mobile Contests on Our Platform."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "12. You will be liable to indemnify Us in the event We suffer any losses on account of Your use of Our Platform or Your failure to abide by this Agreement. Our Restrictions section will let you know how and what you may not use Our Platform for."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "13. To know more the circumstances under which Your access to the Platform or this Agreement may be terminated, read our Termination section."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "14. Your use of this Platform is completely at Your own risk. We disclaim all warranties in relation to the Platform. To understand more please refer to Our Disclaimer section."),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "15. Any dispute between You and Us will be resolved by way of Arbitration which will be conducted in Farrukhabad (UP) by a sole arbitrator appointed by Us. For further details refer to Our Governing law and dispute resolution section."),

//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                     "16. If You have any complaints or grievances over any of the Services offered on the Platform, please contact our Grievance Officer."),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 const Text(
//                   "Safe & Secure transactions Powered by:",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Image(
//                   image: AssetImage("images/razorpay.png"),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 // const Text(
//                 //   "Follow Us On Other Platforms",
//                 //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//                 // ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // Text("How To Play Privacy Policy Terms & Conditions"),
//                     // Text(
//                     //     "Contact Us / About Us / Refund / Cancellation policy"),
//                     Text(
//                       "© 2021 SHAAN Tech Solutions Pvt Ltd. All Rights Reserved",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 10),
//                     ),
//                     Text(
//                         "*This game involes an element of financial risk and may be addictive please play responsibly at your own risk.",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 10)),
//                     Text(
//                         "And you must be 18 years of age to play real money skill games.",
//                         style: TextStyle(fontSize: 10))
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Html(data: """
                    <head>
          <meta charset="UTF-8">
          <meta http-equiv="X-UA-Compatible" content="IE=edge">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>FotoClash | Terms and Conditions</title>
          <link rel="stylesheet" href="./css/sytle.css">
          <link rel="preconnect" href="https://fonts.googleapis.com">
          <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
          <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
      
          <script src="https://unpkg.com/typewriter-effect@latest/dist/core.js"></script>
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/octicons/4.4.0/font/octicons.min.css">
          <link rel="preconnect" href="https://fonts.googleapis.com">
          <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
          <link href="https://fonts.googleapis.com/css2?family=Actor&display=swap" rel="stylesheet">
      
          <link rel="apple-touch-icon" sizes="180x180" href="favicon/apple-touch-icon.png">
          <link rel="icon" type="image/png" sizes="32x32" href="favicon/favicon-32x32.png">
          <link rel="icon" type="image/png" sizes="16x16" href="favicon/favicon-16x16.png">
          <link rel="manifest" href="favicon/site.webmanifest">
          <link rel="mask-icon" href="favicon/safari-pinned-tab.svg" color="#5bbad5">
          <meta name="msapplication-TileColor" content="#da532c">
          <meta name="theme-color" content="#ffffff">
      
      </head>
      
      <body>
          <!-- header start -->
          <div class="header" id="header">
      
      
              <!-- navbar 2 start -->
              <nav class="navbar" style="justify-content: center;">
                  <div class="logo">
                      <a href="index.html">  <img src="./assets/logoblk.svg" alt=""> </a>
                  </div>
      
      
              </nav>
              <!-- navbar end -->
          </div>
          <!-- header end -->
      
      
          <!-- section for page  after nav-->
          <div class="section">
              <h3 class="page-title">
                  Terms and Conditions
              </h3>
              <div class="breadcrumbs">
                  <a href="./index.html" class="main-crumb"> Home</a>/ <span>Terms and Conditons </span>
              </div>
              <div class="contact-div-d">
                  <p>These terms and conditions of use <b>(&ldquo;Terms of Use/Service&rdquo;)</b> along with other policies available on our platform forms a legally binding agreement between You and <b>SHAAN Tech Solutions Pvt. Ltd. (&ldquo;FOTOCLASH&rdquo;, &ldquo;Our&rdquo;, &ldquo;We&rdquo;, &ldquo;Us&rdquo;).</b></p>
      
                  <p>PLEASE READ THESE TERMS OF USE CAREFULLY BEFORE PLAYING ANY CONTEST OR/AND USING THE FOTOCLASH PLATFORM.</p>
                  
                  <p>If You do not agree with any of the Terms of Use/Service or/and Privacy Policy, kindly refrain from using Our services offered through the FotoClash Platform.</p>
                  
                  <p>We have tried Our best to simplify the Terms of Use for your understanding, but We understand that it is a lengthy document. So, We have summarised some of the essentials clauses at the beginning, and provided links(if needed) there that should take You to the relevant clause where You can find more details. We want You to know that the Summary only encapsulates the key aspects of that clause and not the entire clause itself. So, please refer to the details of the clauses for a complete understanding.</p>
                  
                  <p>&bull; You may start using Our web portal https://www.fotoclash.com/ , partner websites, mobile applications and other portals (collectively, the &quot;Platform&rdquo;) only after you have agreed to abide by the terms and conditions that have been laid down in this Agreement. Please refer to the Introduction section, to get a better understanding of the meaning of the various words used in this Terms of Use agreement, and how they may be updated.</p>
                  
                  <p>&bull; A person of sound mind, who is above 18 years of age, may use this Platform.</p>
                  
                  <p>&bull; The Platform may not be used by residents of Kerala, Tamil Nadu, Assam, Odisha, Nagaland, Sikkim, Andhara Pradesh and Telangana. In addition to this, certain Contests /application or anything related to our PLATFORM may be restricted in some additional states. Visit our Eligibility section for more information on who may use the platform.</p>
                  
                  <p>&bull; The steps to register on the platform &amp; add money to Your account have been detailed out under Our Nature and use of the Platform section.</p>
                  
                  <p>&bull; Please note that Your User Details like your username and profile picture will be visible to other users on the Platform.</p>
                  
                  <p>&bull; Your ability to participate in the Contests available on Our Platform are governed by rules that you can read more about in Our Contests. Participation section. It is possible that each Contests may be subject to its own Rules and Code of Conduct. To understand this better please refer further.</p>
                  
                  <p>&bull; Please note that the sole discretion to determine the terms applicable on any Contest including the Awards to be given in any Contest lies with Us. Further, the Entry Fee for any Contest is non-refundable and may only be refunded under the circumstances stated in Our Return, Refund and Cancellation policy.</p>
                  
                  <p>&bull; Winnings in Your account may be withdrawn by You, subject to the completion of KYC verification and will be subject to TDS deductions when applicable.</p>
                  
                  <p>&bull; Our Platform offers only skill-based photographers, models, or who have skills in photoshoot, photography or related to it. To understand more about the nature of Contests offered on Our Platform please refer to the Contests of skill section.</p>
                  
                  <p>&bull; We would also request you to go through our Safety Section to be aware of and follow all the necessary precautions while playing Mobile Contests on Our Platform.</p>
                  
                  <p>&bull; You will be liable to indemnify Us in the event We suffer any losses on account of Your use of Our Platform or Your failure to abide by this Agreement. Our Restrictions section will let you know how and what you may not use Our Platform for.</p>
                  
                  <p>&bull; To know more the circumstances under which Your access to the Platform or this Agreement may be terminated, read our Termination section.</p>
                  
                  <p>&bull; Your use of this Platform is completely at Your own risk. We disclaim all warranties in relation to the Platform. To understand more please refer to Our Disclaimer section.</p>
                  
                  <p>&bull; Any dispute between You and Us will be resolved by way of Arbitration which will be conducted in Farrukhabad (UP) by a sole arbitrator appointed by Us. For further details refer to Our Governing law and dispute resolution section.</p>
                  
                  <p>&bull; If You have any complaints or grievances over any of the Services offered on the Platform, please contact our Grievance Officer.</p>
                  
                  <p><strong>1. INTRODUCTION</strong></p>
                  
                  <p>1. SHAAN Tech Solutions Private Limited is an Indian company incorporated under the Companies Act, 2013. Which( i.e fotoclash) offers skill and learning based digital Contests which are developed by FotoClash.</p>
                  
                  <p>2. Capitalized terms used herein but not defined shall have the meanings ascribed to them under section 1.9 (Definitions and Interpretation) of this Agreement.</p>
                  
                  <p>3. This Agreement shall apply to all Persons who visit the Platform, or create a player Account on the Platform (the &ldquo;Users&rdquo;, &ldquo;You&rdquo; or &ldquo;Your&rdquo;).</p>
                  
                  <p>4. By registering on, browsing, downloading, using or accessing any part of the Platform or utilizing the Services, the Users agree to be bound by this Agreement.</p>
                  
                  <p>5. If at any time the User does not accept or agree to any terms of this Agreement, on a continuing basis in relation to any of the Services offered on the Platform, they should not access the Platform.</p>
                  
                  <p>6. FOTOCLASH reserves the right to periodically review, update, change or replace any part of these Terms of Use or other terms of the Agreement as it may consider appropriate at its sole and absolute discretion</p>
                  
                  <p>7. Any changes to these Terms of Use will be posted on this page wherever appropriate. The Users must visit this page periodically for updates on the Terms of Use applicable to their use of the Platform.</p>
                  
                  <p>8. Any Users&rsquo; continued usage of the Platform after any such update, change, replacement or modification in the Agreement constitutes their valid consent to such changes.</p>
                  
                  <p>9. Definitions</p>
                  
                  <p>9.1. &ldquo;Agreement&rdquo; shall mean these Terms of Use, the Privacy Policy and any other rules or policies available on the Platform including all other additional or modified terms and conditions and policies in relation to the Platform or any current or future services that may be offered by FOTOCLASH. This Agreement is published in accordance with the provisions of Rule 3(1) of the Information Technology (Intermediary Guidelines) Rules, 2011. This Agreement is an electronic record generated by a computer system and does not require any physical or digital signatures.</p>
                  
                  <p>9.2. &ldquo;Applicable Law&rdquo; means all laws, statutes, common law, regulations, ordinances, codes, rules, guidelines, orders, permits, tariffs and approvals, including those relating to health and safety, of any governmental authority or self-regulatory guideline that may apply to the Users or is related to the subject matter of this Agreement as applicable in the territory of India.</p>
                  
                  <p>9.3. &ldquo;Contests&rdquo; is a skill based competition offered by FOTOCLASH on the Platform in which Users compete either in a tournament or 1v1 battle by uploading their photos in VS to the other users of the application on the Platform. Contests can be either &lsquo;paid&rsquo; or &lsquo;free to play&rsquo;. Paid Contests require the Users to pay an Entry Fee for participation, whereas free to play Contests are open to all Users without any Entry-Fee.</p>
                  
                  <p>9.4. &ldquo;Balance&rdquo; is the credit available in an Account and includes the amount added by a User through Deposits or/and earned through Winnings by participating in Contests on the Platform.</p>
                  
                  <p>9.5. &ldquo;Deposit&rdquo; is the amount added by the User to his/her Account through his/her preferred payment mode (e-wallet, debit/credit cards, UPI/BHIM, net banking). The Deposit conversion ratio is INR. 1/- (Rupees One Only) = INR 1 (one).</p>
                  
                  <p>9.6. &ldquo;Entry-Fee&rdquo; refers to the fee which Users pay either in the form of cash Balance available in their Account to participate in a Contests on the Platform.</p>
                  
                  <p>9.7. &ldquo;Mobile Contests &rdquo; refers to the digital Contests of skill available on the Platform developed/created by FOTOCLASH or by the user.</p>
                  
                  <p>9.8. &ldquo;Person&rdquo; shall mean any natural person, limited or unlimited liability company, corporation, partnership (whether limited or unlimited), proprietorship, any religion undivided family, trust, union, association, government or any agency or political subdivision thereof or any other entity that may be treated as a person under the Applicable Law.</p>
                  
                  <p>9.9. &ldquo;Winnings&rdquo; are awards (either in the form of cash, promo or promotional gifts) given to a User for winning or/and performing well in a particular Contests on the Platform.</p>
                  
                  <p>10. Interpretation</p>
                  
                  <p>10.1. Any reference to the singular includes a reference to the plural and vice versa, and any reference to one gender includes a reference to other gender(s), unless explicitly provided for.</p>
                  
                  <p>10.2. Headings and captions are used for convenience only and not for interpretation of the Agreement.</p>
                  
                  <p>10.3. Any reference to a natural Person shall, include his/her heirs, executors and permitted assignees and any reference to a juristic Person shall, include its affiliates, successors and permitted assignees, unless repugnant to the context.</p>
                  
                  <p><strong>2. ELIGIBILITY</strong></p>
                  
                  <p>1. Any browsing, registering, downloading, using or accessing by any Person of any part of the Platform or utilisation of any of the services offered by FOTOCLASH will be deemed to constitute a legal contract between the User and FOTOCLASH.</p>
                  
                  <p>2. A User may use the Platform if (a) it is a natural Person, as per any Applicable Law, regulation or generally accepted practices or guidelines applicable in the country of India; or (b) it is a juristic Person, as per any Applicable Law, regulation or generally accepted industry practices and guidelines applicable in the country of India.</p>
                  
                  <p>3. Any User who is &ldquo;incompetent to contract&rdquo; within the meaning of the Indian Contract Act, 1872 including minors, un-discharged insolvents etc. is not eligible to enter into this Agreement with FOTOCLASH.</p>
                  
                  <p>4. The Platform should not be used, installed, or played by any Person under the age of 18 years.</p>
                  
                  <p>5. No Person, whether a FOTOCLASH employee or not, who is involved in the development of Mobile Contests or/and algorithms on the Platform can participate in any Mobile Contests on the Platform, where such participation could alter, modify or unduly influence his/her performance on the Mobile Contests , without express written permission of FOTOCLASH and subject to such terms and conditions as FOTOCLASH may seek to impose on such Person.</p>
                  
                  <p>6. The Mobile Contests and the services available on the Platform are open only to Persons currently residing in India. Persons residing in the state of Kerala, Tamil Nadu, Assam, Odisha, Nagaland, Sikkim, Andhara Pradesh and Telangana (&ldquo;Restricted States&rdquo;) are prohibited from participating in any Mobile Contests on the Platform. Further, there may be certain Contests that may be restricted in some additional states. Please check the Special Rules/Terms of each Contests.</p>
                  
                  <p>7. Only those Users who have successfully registered on the Platform in the manner prescribed in section 3 (Nature and Use of the Platform), and who utilize the services of the Platform in accordance with the Agreement including these Terms of Use, shall be eligible to use the Platform.</p>
                  
                  <p>8. Certain services being provided on the Platform may be subject to additional conditions or rules applicable to a particular Mobile Contests in that respect (&ldquo;Contests Terms&rdquo;). Such Contests Terms are deemed to be incorporated herein by reference. Users must agree to these Contests Terms before playing any such Mobile Contests on the Platform. To the extent that these Terms of Use are inconsistent with Contests Terms, the Contests Terms shall prevail.</p>
                  
                  <p>9. FOTOCLASH reserves the right to terminate any User&rsquo;s Account and/or deny access to the Platform if it is brought to FOTOCLASH&rsquo; notice that a particular User has violated the Agreement including any of these Terms of Use.</p>
                  
                  <p><strong>3. NATURE AND USE OF THE PLATFORM</strong></p>
                  
                  <p>1. FOTOCLASH provides the Platform to You on which You can play Mobile Contests either offered by FOTOCLASH or independent user</p>
                  
                  <p>2. Registration You may register by approving and agreeing to this Agreement and providing Your registered mobile phone number on the Platform. You will be verified by FOTOCLASH using a one-time password (&ldquo;OTP&rdquo;) system. Upon successfully verifying the OTP, an account will be created for You (&ldquo;Account&rdquo;).</p>
                  
                  <p>3. By registering for an Account, You represent, warrant and agree that:</p>
                  
                  <p>a) You fulfil the eligibility criteria as detailed in section 2 (Eligibility);</p>
                  
                  <p>b) You are using Your actual identity and the mobile phone number you have provided is registered in Your own name;</p>
                  
                  <p>c) You will provide only true, accurate, current, and complete information about Yourself, including optional information such as Your profile photograph, user-id etc., on the Platform (&ldquo;User Details&rdquo;);</p>
                  
                  <p>d) You will maintain and promptly update the User Details and other information that You provide on the Platform to keep it true, accurate, current, and complete.</p>
                  
                  <p>4. The Users acknowledge that their User Details will be accessible to other User on the Platform and shall be available for FOTOCLASH to create promotional and interactive content over the Platform.</p>
                  
                  <p>5. Your Account is for Your personal use only. You shall not impersonate someone else. By creating an Account after providing a mobile phone number and verifying it using an OTP, You represent, warrant, and agree that You are authorized to use the Platform and will abide by the Agreement.</p>
                  
                  <p>6. Privacy</p>
                  
                  <p>a) Our privacy policy available at Privacy Policy section of the mobile app (&ldquo;Privacy Policy&rdquo;) explains how We treat Your personal data and protect Your privacy when You use the Platform and our Services. By using the Platform, You agree that We can use Your data and other information according to the Privacy Policy.</p>
                  
                  <p>b) You are responsible for maintaining the confidentiality of passwords associated with any device You use to access the Platform. Accordingly, You are solely responsible for all activities that occur with Your device. If You become aware of any unauthorised use of Your device, You are required to notify the relevant authorities as soon as possible.</p>
                  
                  <p>7. Deposits</p>
                  
                  <p>a) In order to participate in certain Contests , the Users may be required to pay an Entry Fee in the form of cash. Users may add cash to their Account by using any of the payment modes available on the Platform.</p>
                  
                  <p>b) The Deposits may be used to participate in Contests in the manner provided under section 4 (Participation in Contests )</p>
                  
                  <p>8. Each User is solely responsible for all activities that occur under their Account, including the use of any of the Services on the Platform.</p>
                  
                  <p>9. FOTOCLASH grants such Users a non-transferrable, limited, non-exclusive and revocable privilege to register an Account on and use the Platform.</p>
                  
                  <p>10. If FOTOCLASH identifies that the same User Details are being used under multiple accounts, then FOTOCLASH at its sole discretion will terminate/deactivate the Account without the Users&rsquo; consent and any Deposit in the Account will not be refunded.</p>
                  
                  <p>11. FOTOCLASH, at its sole and absolute discretion and without any notice to the Users, reserves the right to restrict, suspend or terminate any Account or access to the Platform temporarily or permanently to any User.</p>
                  
                  <p>12. FOTOCLASH may, at its sole and absolute discretion restrict, change, suspend, or terminate any User&rsquo;s access to all or any part of the Platform, including but not limited to:</p>
                  
                  <p>a) reject, move, or remove any material that may be submitted by the User;</p>
                  
                  <p>b) move or remove any content that is available on the Platform;</p>
                  
                  <p>c) deactivate or delete an Account and all related information and files on their Account;</p>
                  
                  <p>d) establish general practices and limits concerning use of the Platform and the services; and</p>
                  
                  <p>e) assign its rights and liabilities with respect to all Accounts hereunder, to any entity.</p>
                  
                  <p>13. Notwithstanding anything to the contrary herein, the Users acknowledge and agree that they shall have no ownership or other interest in their Account, and further acknowledge and agree that all rights in and to their Account are and shall forever be owned by and inure to the benefit of FOTOCLASH.</p>
                  
                  <p>14. The Users also accepts to receive news, updates, offers/campaign related SMS, to the mobile phone number and email provided by the User, except when prohibited under Applicable Laws.</p>
                  
                  <p>15. Platform Fee Information</p>
                  
                  <p>a) The actual house edge for all the products/Contests is between 0% and 30% and under extreme exceptional cases may go beyond this range. This can be easily deduced from the entry fee and the total prize offered.</p>
                  
                  <p><strong>4. PARTICIPATION IN CONTESTS </strong></p>
                  
                  <p>1. The Users may use the Platform to participate in a variety of Contests available on the Platform.</p>
                  
                  <p>2. In order to participate in a Contests, each User may be required to pay an Entry Fee to the Platform which is deducted from the Balance available in the Account of the User.</p>
                  
                  <p>3. Any amount received by FOTOCLASH as Entry Fee for participation in a Contests shall be non-refundable, except in the event that a Contests has been cancelled/drawn(no result).</p>
                  
                  <p>4. Contests shall be announced by FOTOCLASH from time to time in any manner that is convenient to the Company, and FOTOCLASH reserves the right to extend the participation and time limit for registration, cancel any Contests , and modify any terms, all with due notice to the Users of the Platform.</p>
                  
                  <p>5. Contests can also be created by uploading their photo on the respective field and other interest user will accept your contest.</p>
                  
                  <p>6. Winnings</p>
                  
                  <p>a) Awards for all Contests shall be pre-declared at the time of registration in the specific rules applicable to such Contests. Awards may be in the form of FOTOCLASH Tokens, cash or promotional gifts.</p>
                  
                  <p>b) Users are eligible to withdraw only cash Winnings from his/her Account to his/her respective bank/wallet account once it is KYC (Know Your Customer) verified.</p>
                  
                  <p>c) KYC verification is mandatory as a proof of identity for making withdrawals from Your Account to Your bank/wallet account. KYC verification may be done through the Platform by providing certain details: (i) photograph of a valid government ID (Aadhaar Card, Driving License, PAN Card, Voter Card etc.); and (ii) other User Details.</p>
                  
                  <p>d) FOTOCLASH does not issue receipts for entries in the Contests The entries are accounted within the Account on the Platform. It is the responsibility of the Users to ensure that the entries are accurate and the Winnings are duly credited to his Account.</p>
                  
                  <p>e) Any tax/levies/duty etc., as applicable on material prizes, shall be paid by the winner of the Contests. Based on TDS (tax deducted at source) Rules for any sort of Contests winning in India, 30% TDS should be deducted on any winning above Rs.10,000/- in a single Contests .</p>
                  
                  <p>7. Return, Refund and Cancellation</p>
                  
                  <p>a) In the event that there is an error in the Services provided by us, we may refund the Entry Fee, provided the reasons are genuine and proved after investigation by FOTOCLASH.</p>
                  
                  <p>b) Please read the rules of each Mobile Contests and Contests/contest before participating.</p>
                  
                  <p>c) We do not cancel registrations once entered, however, in case of exceptional circumstances wherein the fault may lie with the payment gateway or from Our side, We will cancel your participation on request and refund the Entry Fee to You within a reasonable amount of time.</p>
                  
                  <p>d) . In case we cancel your participation in any Mobile Contests or Contests as a result of this, We will return Your Entry Fee to You within a reasonable amount of time for You to redeem the same by playing other Contests s/contests on FOTOCLASH.</p>
                  
                  <p>e) . We will try Our best to create the best user experience for You. If paid by credit card, refunds will be issued to the original credit card provided at the time of purchase and in case of payments made through a payment gateway, payment refunds will be made to the same account.</p>
                  
                  <p>8. In order to comply with extant law relating to deposit regulations, please note that the Users must withdraw any idle Balance lying in their Account within 365 days of having won a particular Contests. Similarly, Users must use any money in their Account within 365 days. If not, the said Balance will have to be forfeited by FOTOCLASH.</p>
                  
                  <p>5. MOBILE CONTESTS</p>
                  
                  <p>1. The Platform is operated and designed to provide you the 1v1 photo contests between two users and one them will be the winner.</p>
                  
                  <p>2. The Mobile Contests will have their own rules and code of conduct (&ldquo;Contests Rules&rdquo;) which shall be adhered to by all Users at all times.</p>
                  
                  <p>3. When You play a Mobile Contests , You agree and acknowledge that the Platform does not create and/or broadcast any content on its own accord and FOTOCLASH is not responsible or liable for the content or accuracy of the Mobile Contests , including copyrights, that may be accessed by You through the Platform.</p>
                  
                  <p><strong>6. CONTESTS OF SKILL</strong></p>
                  
                  <p>1. The Mobile Contests hosted by FOTOCLASH or by the users on the Platform are all Contests of Skill (defined below). Different Mobile Contests will reward different skills, but each Contests will reward certain skills, such as knowledge of the Contests , familiarity with rules, experience, reflexes, practice, hand-eye coordination etc</p>
                  
                  <p>2. Users must note that all Mobile Contests available on the Platform are Contests where the success or/and performance of the Users depends predominantly upon their superior knowledge, training, attention, experience and adroitness (&ldquo;Game of Skill&rdquo;) in playing the Contests . &lsquo;Game of Skill&rsquo;, under Indian law, are excluded from the ambit of gambling legislations including, the Public Gambling Act of 1867 and other state enactments except in the Restricted States.</p>
                  
                  <p>3. Hence, the individuals residing in the Restricted States should not participate in any Contests or Mobile Contests offered on the Platform. Any participation by such individuals shall be at their sole risk and discretion and FOTOCLASH shall not be liable to refund or reimburse any injury or damages suffered by such individuals.</p>
                  
                  <p>4. FOTOCLASH reserves the right to monitor all activities from the User&rsquo;s Account on the Platform. If any User participates in any Contests or Mobile Contests in violation of any central and/or state law(s) in India, FOTOCLASH reserves the right to cooperate with law enforcement agencies of the relevant state and report such participation or/and suspicious activity along with all relevant details of the concerned User.</p>
                  
                  <p>5. FOTOCLASH does not support, endorse or offer to any User &lsquo;Contests/game of chance&rsquo; for money. Each Mobile Contests and Contests available on the Platform has clearly defined rules and code of conduct. All Users are encouraged to read, understand and follow these rules to be successful in these Contests. FOTOCLASH shall not be liable if Users do not adhere to the Contests Rules or otherwise engage in gambling or betting activities on the Platform.</p>
                  
                  <p>7. SAFETY PRECAUTION AND RESPONSIBLE GAMING</p>
                  
                  <p>1. FOTOCLASH suggests that Users adopt a balanced approach while engaging with any of the Mobile Contests on the Platform and safeguard themselves against any adverse effects. If played responsibly, Mobile Contests (like other forms of sports) aim to encourage Users to develop their mental prowess, hand-eye co-ordination, competitiveness and encourage teamwork.</p>
                  
                  <p>2. You should take certain standard health and safety precautions while playing any Mobile Contests , including taking adequate breaks, sitting at a reasonable distance from the screen, in a well-lit environment, and avoiding playing when tired, drowsy, intoxicated or under the influence of drugs. Avoid playing without breaks over long periods of time as this could affect Your performance and could negatively impact hand-eye coordination, balance, and multi-tasking ability.</p>
                  
                  <p>3. Playing Contests, It can be addictive ,can have financial loses, if you are ready to bear this , then play at your own risk.. And if you are still in a dilemma then we strongly advise you not to use our Platform/Mobile App/ or website.</p>
                  
                  <p>4. You agree that Your use of the Platform and to play the Mobile Contests is at Your own risk, and it is Your responsibility to maintain such health, liability, hazard, personal injury, medical, life, and other insurance policies as You deem reasonably necessary for any injuries that You may incur while using the Platform.</p>
                  
                  <p>5. You hereby agree that if the terms of this Agreement are not adhered by You, FOTOCLASH will be irreparably damaged, and therefore You agree that the Platform shall be entitled, without bond, other security, proof of damages, to appropriate equitable remedies with respect to any breach of this Agreement, in addition to any other remedies available under Applicable Law.</p>
                  
                  <p>8. RESTRICTIONS ON YOUR USE OF THE PLATFORM</p>
                  
                  <p>1. You will not use the Platform, or any content provided thereof for any purpose that is illegal, unlawful or prohibited by this Agreement or under Applicable Law.</p>
                  
                  <p>2. You will not use the Platform, or any content provided thereof:</p>
                  
                  <p>1. to host, display, upload, modify, publish, transmit, update or share any information that belongs to another Person and to which the User does not have any right to;</p>
                  
                  <p>2. is grossly harmful, harassing, blasphemous, defamatory, obscene, pornographic, paedophilic, libellous, invasive of another&rsquo;s privacy, hateful, or racially, ethnically objectionable, disparaging,</p>
                  
                  <p>3. that is relating to or encourages money laundering or gambling, or is otherwise unlawful in any manner whatsoever;</p>
                  
                  <p>4. that harms minors in any way;</p>
                  
                  <p>5. that infringes any patent, trademark, copyright or other proprietary rights; violates any Applicable Law for the time being in force;</p>
                  
                  <p>6. that deceives or misleads the addressee about the origin of such messages or communicates any information which is grossly offensive or menacing in nature;</p>
                  
                  <p>7. which impersonates another Person; contains software viruses or any other computer code, files or programs designed to interrupt, destroy or limit the functionality of the Platform or any other computer resource;</p>
                  
                  <p>8. that threatens the unity, integrity, defence, security or sovereignty of India, friendly relations with foreign states, or public order, or causes incitement to the commission of any cognisable offence or prevents investigation of any offence or is insulting any other nation; threatens public health or safety; promotion of cigarettes or any other tobacco products or consumption of intoxicant including alcohol and Electronic Nicotine Delivery System (ENDS) and like products that enable nicotine delivery except for the purpose &amp; in the manner and to the extent, as may be approved under the Drugs and Cosmetics Act, 1940 and Rules made thereunder; threatens critical information infrastructure.</p>
                  
                  <p>3. You will not redistribute, sublicense, rent, publish, sell, assign, lease, market, transfer, or otherwise make the Platform or any component or content thereof, available to third parties without the permission of FOTOCLASH.</p>
                  
                  <p>4. You will not circumvent or disable any digital rights management, usage rules, or other security features of the Platform; remove, alter, or obscure any proprietary notices (including copyright notices) on any portion of the Platform; and not use the Platform in a manner that threatens the integrity, performance, or availability of the Platform.</p>
                  
                  <p>5. You will not attempt to or engage in any activity that may:</p>
                  
                  <p>1. reverse engineer, decompile or otherwise extract the source code related to the Platform or any part thereof, unless it is expressly permitted by FOTOCLASH to You in writing or is required by the Applicable Law;</p>
                  
                  <p>2. use any robot, spider, retrieval application, or other device to retrieve or index any portion of the Platform or content thereof;</p>
                  
                  <p>3. collect information about Users for any illegal or unlawful purpose;</p>
                  
                  <p>4. create any Account by automated means or under false or fraudulent pretences for using the Platform;</p>
                  
                  <p>5. transmit any viruses, worms, defects, trojan horses, or any items of a destructive nature through the Platform;</p>
                  
                  <p>6. use the Platform in any manner that could damage, disable, overburden, or impair, or undertake any action which is harmful or potentially harmful to, any of the servers, networks, computer systems or resources connected to any of the servers connected, directly or indirectly to the Platform, or interfere with any other Users&rsquo; use and enjoyment of the Platform;</p>
                  
                  <p>7. carry out any denial of service (DoS, DDoS) or any other harmful attacks on the Platform or; disrupt or place unreasonable burdens or excessive loads on, or interfere with or attempt to make, or attempt any unauthorized access to the Platform or any part of the Platform or any User of the Platform;</p>
                  
                  <p>8. forge headers or otherwise manipulate identifiers to disguise the origin of any content transmitted through the Platform; and/or</p>
                  
                  <p>9. obtain any materials or information through any means not intentionally made available, in the opinion of FOTOCLASH, through the Platform.</p>
                  
                  <p>6. You will not impersonate another Person or impersonate, guide or host on behalf of, or falsely state or otherwise misrepresent Your affiliation with any Person or entity, including, but not limited to Our officials, employees, agents, partners, affiliates, dealers and franchisees.</p>
                  
                  <p>7. If We detect any activity from Your User Account that is fraudulent, suspected to be defrauding the Platform, or if You are found colluding or participating in any kind of fraudulent activity on the Platform in any manner, then You shall be debarred from participating in any Contests available on the Platform.</p>
                  
                  <p>8. We reserve the right to deactivate or delete Your Account and all related information on it and forfeit related Balances and/or take any other appropriate action, at our sole and absolute discretion, in the event of any fraudulent, illegal or suspicious activities from Your Account on the Platform.</p>
                  
                  <p>9. Any deductions or forfeiture of Balances made from Your Account shall be made at Our sole and absolute discretion and shall not result in any liability on FOTOCLASH whatsoever. We may choose to provide a right of appeal to the User after deleting, closing or forfeiting the balances in his/her Account. However, such right shall be provided at the sole and absolute discretion of FOTOCLASH and the User shall not claim such right or any other recourse from FOTOCLASH.</p>
                  
                  <p>10. Indemnification:You shall defend, indemnify and hold FOTOCLASH, and its officers, directors, employees, representatives and agents harmless from and against any claims, actions, demands, liabilities, judgments, and settlements, including without limitation, reasonable legal fee that may result from or alleged to result from (a) Your use of the Platform or any content thereof, including Mobile Contests ; or (b) Your breach of any rules, regulations and/or orders under any applicable law.</p>
                  
                  <p>11. You are also responsible for any breach of Your obligations under the Agreement and/or for the consequences of any such breach.</p>
                  
                  <p>9. TERMINATION</p>
                  
                  <p>1. Your access to the Platform may be terminated if:</p>
                  
                  <p>1. You voluntarily uninstall the Platform from Your device;</p>
                  
                  <p>2. You knowingly or unknowingly cause direct or indirect breach, as ascertained by FOTOCLASH, of these Terms of Use or Privacy Policy as a whole or in part; or</p>
                  
                  <p>3. You do not pay the requisite fee, if any, should FOTOCLASH charge for use of the App.</p>
                  
                  <p>2. We may have to terminate Your access to the Platform if:</p>
                  
                  <p>1. We are required to do so by law (for example, where the access to and/or provision of the Platform to You becomes, unlawful);</p>
                  
                  <p>2. The third-party Person, if any, with whom We offered the Platform to You has terminated its relationship with Us or ceased to offer the related services to Us or to You;</p>
                  
                  <p>3. The provision of Platform to You, is no longer commercially viable or feasible for Us; or</p>
                  
                  <p>4. You are a repeat infringer of this Agreement.</p>
                  
                  <p>3. We may terminate this Agreement at any time, with or without notice and may disable Your access to the Platform and/or bar You from any future use of the Platform.</p>
                  
                  <p>4. You may terminate this Agreement at any time by terminating Your access to the Platform. However, certain obligations of Yours under this Agreement shall continue to prevail even on such termination.</p>
                  
                  <p>5. When this Agreement comes to an end, all of the legal rights, obligations and liabilities that You and FOTOCLASH have benefited from, been subject to (or which have accrued over time whilst the Agreement has been in force) or which are expressed to continue indefinitely, shall be unaffected by this cessation, and shall continue to apply to such rights, obligations and liabilities indefinitely.</p>
                  
                  <p>10. DISCLAIMERS</p>
                  
                  <p>1. No warranties: The Contents provided through the Platform may include technical inaccuracies or typographical errors. FOTOCLASH may make changes or improvements to the Platform at any time. The Contents or any information available on the Platform is provided &ldquo;as is&rdquo; and &ldquo;as available&rdquo; and without warranties of any kind either expressed or implied, to the fullest extent permissible pursuant to Applicable Laws, including but not limited to:</p>
                  
                  <p>1. any implied warranty or merchantability, fitness for a particular purpose;</p>
                  
                  <p>2. that the contents of the Platform will be uninterrupted or error-free;</p>
                  
                  <p>3. that defects, if any on the Platform will be corrected;</p>
                  
                  <p>4. the Platform being constantly available or available at all;</p>
                  
                  <p>5. installation or uninstallation choices in relation to the Platform being successfully executed in all cases;</p>
                  
                  <p>6. Your personal ability to use the Platform;</p>
                  
                  <p>7. Your satisfaction with the use of the Platform;</p>
                  
                  <p>8. the accuracy of the data provided by the Platform;</p>
                  
                  <p>9. the security and privacy of Your data;</p>
                  
                  <p>10. that all bugs or errors in relation to the Platform will be corrected;</p>
                  
                  <p>11. that the Platform will be compatible with all devices and all networks;</p>
                  
                  <p>12. that the Platform is fit for a particular purpose or use;</p>
                  
                  <p>13. that the Platform and the contents thereof are accessible in every location; or</p>
                  
                  <p>14. that the Platform and the contents would be perpetually secure and not prone to breaches of security anywhere in the world.</p>
                  
                  <p>2. FOTOCLASH, its officers, directors, employees, affiliates and agents and any other service provider(s) responsible for providing access to the Platform in connection with this Agreement will not be liable for any acts or omissions, including of a third party Person, and including those vendors participating in FOTOCLASH&rsquo; offerings made to You, or for any unauthorized interception of data or breaches of this Agreement attributable in part to the acts or omissions of third parties Persons, or for damages that result from the operation systems, equipment, facilities or services provided by third parties Persons that are interconnected with FOTOCLASH.</p>
                  
                  <p>3. The Platform may include links to other mobile applications and/or websites (some of which may be automated search results) which may contain materials that are objectionable, unlawful, or inaccurate. We do not endorse or support these links or the products and services they provide; these links are provided for Your convenience only. We are not responsible or liable for the content or accuracy of such links.</p>
                  
                  <p>4. We may stop provision of the Platform (or any part thereof), permanently or temporarily, to You or to Users generally or may modify or change the nature of the Platform and/or these Terms of Use at Our sole discretion, without any prior notice to You. Your use of the Platform following any such modification constitutes Your deemed acceptance to be bound by the Agreement (or as it may be modified).</p>
                  
                  <p>5. You agree that You are responsible for all data charges You incur through use of the Platform.</p>
                  
                  <p>6. Limitation of liability: Your use of the Platform, or any content, including Mobile Contests, available thereof is entirely at Your own option and risk and We shall be held harmless and not be liable for any direct, indirect, incidental, consequential, special, exemplary, punitive, monetary or any other damages, fees, fines, penalties or liabilities whatsoever arising out of or relating to Your use of the Platform or any content thereof, including Mobile Contests. To the maximum extent permitted by Applicable Law, Our total liability to You for any damages (regardless of the foundation for the action) shall not exceed in the aggregate the Balance in your Account.</p>
                  
                  <p>7. You may terminate Your access to the Platform if You are not satisfied with the Platform or any Mobile Contests.</p>
                  
                  <p>8. Force Majeure: FOTOCLASH shall not be liable for any damages whatsoever arising out of Force Majeure Event or other similar circumstances, directly or indirectly to the Users as a result of playing Mobile Contests or using the services offered by FOTOCLASH on the Platform. A Force Majeure Event is a real or potential labour disputes, governmental actions, war or threat of war, sabotage, civil unrest, demonstrations, fire, storm, flooding, explosion, earthquake, provisions or limitations of materials or resources, inability to obtain the relevant authorization, accident, and defect in electricity or telecommunication network that affects the Company&rsquo;s ability to offer the services or/and the Mobile Contests on the Platform. Force majeure or other event beyond FOTOCLASH&rsquo; control hindering, delaying or complicating the maintenance of the Platform entitles FOTOCLASH to suspend or limit the Platform until further notice.</p>
                  
                  <p>CONTESTS ON FOTOCLASH</p>
                  
                  <p>Here on our platform Contests means that any user can CREATE CONTEST in which he/she has to upload his/her photo from gallery or camera of the phone then this uploaded photo will automatically be uploaded on the ACCEPT CONTESTS page where other users of our platform can accept that contest by also uploading his/her pic in the same manner as above, and there may be a entry fee on uploading photo, creating contest or accepting contest. After this both user&rsquo;s photo will display on &lsquo;Like Your Favourite&rsquo; page ,in Vs. And the rest of the users will like the best photo. And then the users after 24 Hrs, one of them will be the Winner on the basis of highest Likes. And he/she will be rewarded as mention above on this document.</p>
                  
                  <p>11. GOVERNING LAW AND DISPUTE RESOLUTION</p>
                  
                  <p>1. The Platform may be controlled and operated through any country and will be subject to the laws of that state in which they are controlled and operated by the User. If You use the Platform from any location, then, You are responsible for compliance with the local laws applicable to You.</p>
                  
                  <p>2. All or any disputes arising out of or touching upon or in relation to this Agreement including the interpretation and validity of the terms thereof and the respective rights and obligations of the parties shall be settled through arbitration. The arbitration shall be governed by the Arbitration &amp; Conciliation Act, 1996 (India) or any statutory amendments/modifications thereto for the time being in force.</p>
                  
                  <p>3. The arbitration proceedings shall be held at Farrukhabad, Uttar Pradesh by a sole arbitrator who shall be appointed by FOTOCLASH and whose decision shall be final and binding upon all the parties.</p>
                  
                  <p>4. Subject to the arbitration clause, the courts at Farrukhabad, Uttar Pradesh alone shall have the jurisdiction. The language of the arbitration proceedings shall be in English.</p>
                  
                  <p>5. You and FOTOCLASH agree that any cause of action arising out of Your use of the Platform must be commenced within 3 (three) months after the cause of action accrues or You become aware of the facts giving rise to the cause of action, whichever is later. Otherwise, such cause of action shall be permanently barred.</p>
                  
                  <p>GRIEVANCE OFFICER</p>
                  
                  <p>In accordance with the Information Technology Act 2000 and rules made thereunder, We have a Grievance Officer to address Your concerns regarding data safety, privacy, and the Platform usage concerns including complaints You have against other users on the Platform. We will resolve these issues raised by You within 30 (thirty) days from receiving them. You may contact the Grievance Officer at the following coordinates:</p>
                  
                  <p>Name - Akash Gupta</p>
                  
                  <p>(GRIEVANCE OFFICER)</p>
                  
                  <p><a class="email" href="mailto:connectakash@fotoclash.com">connectakash@fotoclash.com </a></p>
                  
                  <p>Regards</p>
                  
                  <p>Teame FotoClash</p>
                  </div>
                  </div>
          <!-- main -->
      
          
      
          <footer class="footer">
              <div class="footer-head">
                  <img src="./assets/logo.svg" alt="">
              </div>
              <div class="footer-social">
                  <h3>Follow Us On Other Platforms</h3>
                  <div class="social-icons">
                      <a href="https://www.facebook.com/FotoClash-106935538710537/">
                          <img src="./assets/SVG/fbicon.svg" alt="">
                      </a>
                      <a href="https://instagram.com/fotoclashapp?utm_medium=copy_link">
                          <img src="./assets/SVG/instaicon.svg" alt="">
                      </a>
                     
                      <a href="https://youtube.com/channel/UCxMnokQs57ukNAcIKlWMU1Q">
                          <img src="./assets/SVG/youtubeicon.svg" alt="">
                      </a>
                  </div>
              </div>
              <div class="footer-menu">
                  <div class="row">
                      <a href="howto.html">How To Play </a>
                      <a href="privacy.html">Privacy Policy </a>
                      <a href="#">Terms & Conditions </a>
                  </div>
                  <div class="row">
                      <a href="legal.html">Legality </a>
                      <a href="contact.html">Contact Us </a>
                      <a href="About Us.html">About Us </a>
                      <a href="refund.html">Refund/Cancellation policy </a>
                  </div>
                  <div>
                      &#169; <small>2021 SHAAN Tech Solutions Pvt Ltd. All Rights Reserved</small>
                  </div>
              </div>
              <div class="footer-note">
                  <small>
                      *This game involes an element of financial risk and may be addictive please play responsibly at your own
                      risk.
                      <br>
                      And you must be 18 years of age to play real money skill games.
                  </small>
              </div>
          </footer>
          <script src="./js/main.js"></script>
          <!-- Placed at the end of the document so the pages load faster -->
          <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
              integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous">
          </script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
              integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous">
          </script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
              integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous">
          </script>
      </body>
              """),
          ],
        ),
      ),
    );
  }
}
