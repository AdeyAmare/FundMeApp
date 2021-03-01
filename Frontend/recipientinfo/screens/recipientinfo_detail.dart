import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundme/recipientinfo/recipientinfo.dart';

class RecipientInfoDetail extends StatelessWidget {
  static const routeName = '/recipientinfoDetail';
  final RecipientInfo recipientinfo;

  RecipientInfoDetail({@required this.recipientinfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.recipientinfo.recipientId}'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              AddUpdateRecipientInfo.routeName,
              arguments: RecipientInfoArgument(recipientinfo: this.recipientinfo, edit: true),
            ),
          ),
          SizedBox(
            width: 32,
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<RecipientInfoBloc>().add(RecipientInfoDelete(this.recipientinfo));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RecipientInfosList.routeName, (route) => false);
              }),
        ],
      ),
      body: Card(
        child: Container(
          padding: const EdgeInsets.all(10.0),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // ListTile(
            //   title: Text('Title: ${this.course.title}'),
            //   subtitle: Text('ECTS: ${this.course.ects}'),
            // ),
            Text(
              'First Name: ${this.recipientinfo.firstName}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Last Name: ${this.recipientinfo.lastName}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Description: ${this.recipientinfo.description}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Goal: ${this.recipientinfo.goal}birr',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            (this.recipientinfo.approval == 'no')?Text(
              'Approved: ${this.recipientinfo.approval}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,color: Colors.red,
              ),
            ):Text(
              'Approved: ${this.recipientinfo.approval}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,color: Colors.green,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            (this.recipientinfo.approval == 'no')?RaisedButton(
              child: Text('Approve'),
              onPressed: (){
                RecipientInfoEvent event = RecipientInfoUpdate(
                              RecipientInfo(
                               recipientId: this.recipientinfo.recipientId,
                               firstName: this.recipientinfo.firstName,
                               lastName: this.recipientinfo.lastName,
                               address: this.recipientinfo.address,
                               phoneNumber: this.recipientinfo.phoneNumber,
                               email: this.recipientinfo.email,
                                image: this.recipientinfo.image,
                                description: this.recipientinfo.description,
                                attachment: this.recipientinfo.attachment,
                               // date: this.recipientinfo.date,
                                accountNo: this.recipientinfo.accountNo,
                                goal: this.recipientinfo.goal,
                                balance: this.recipientinfo.balance,
                                current: this.recipientinfo.current,
                                approval: 'yes',
                                
                              ),
                            );
                      BlocProvider.of<RecipientInfoBloc>(context).add(event);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          RecipientInfosList.routeName, (route) => false);

            },):SizedBox(),
            
          ],
        ),
      ),
      ),
    );
  }
}
