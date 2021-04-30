const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.updateUserDetails = functions.firestore
	.document('/users/{id}')
	.onUpdate(async (change, context) => {
		//console.log(change.after.data());

		const id = context.params.id;
		const currentEmail = change.before.get('email');
		const currentMobile = change.before.get('mobile');
		const curDeviceToken = change.before.get('deviceToken');
        
        const deviceToken = change.after.get('deviceToken');
		const newEmail = change.after.get('email');
		const newMobile = change.after.get('mobile');
		
        const timestamp = new Date()
        
        
		const newAlert = admin.firestore().collection(`users/${id}/notifications`);

        if (currentEmail != newEmail) {
			return newAlert.add({ alert: `Your email has been changed to ${newEmail}.\n
            If you did not make this change please contact us.`, date: `${timestamp}` }); 
		}
		if (currentMobile != newMobile) {
			return newAlert.add({ alert: `Your mobile number has been changed to ${newMobile}.\n
            If you did not make this change please contact us.`, date: `${timestamp}` });
        }
        if (curDeviceToken != deviceToken) {
			return newAlert.add({ alert: `Thanks for signing up ${firstName} ${lastName}`, date: `${timestamp}` });
		}
		return null;
		
    });


exports.updateTransferDetails = functions.firestore
    .document('users/{uid}/transfers/{id}')
    .onUpdate(async (change, context) => {
        //console.log(change.after.data());

		const uid = context.params.uid;
		
		const receiverName = change.before.get('receiverName');
		const status = change.before.get('status');

		const newReceiverName = change.after.data('receiverName');
		const newStatus = change.after.get('status');

        const timestamp = new Date()

        const newAlert = admin.firestore().collection(`users/${uid}/notifications`);

        if (status != newStatus) {
			return newAlert.add({ alert: `Your transfer to ${receiverName} is completed.`, date: `${timestamp}` });
		}
        if (receiverName != newReceiverName) {
			return newAlert.add({ alert: `The receiver name has been changed to ${newReceiverName}.`, date: `${timestamp}` });
        }
        return null;
    })


exports.transferActivities = functions.firestore
	.document('users/{uid}/transfers/{id}')
	.onCreate(async (snapshot, context) => {
		//console.log(snapshot.data());

		const uid = context.params.uid;
    
        const timestamp = new Date()
		const receiverName = snapshot.data().receiverName;
		console.log(receiverName)
        
        const newAlert = admin.firestore().collection(`users/${uid}/notifications`).add({ alert: `Your transfer to ${receiverName} is pending.`, date: `${timestamp}` });
	});
	
exports.topicsPush = functions.firestore
	.document('/{notifications}/{id}')
	.onWrite(async(change) => {
		// let title = change.after.get('date');
		// let content = change.after.get('alert');
		// var message = {
		// 	notification: {
		// 		title: title,
		// 		body: content,
		// 	},
		// 	topic: 'testing'
		// };

		// let response = await admin.messaging().send(message);
		// console.log(response);

});

exports.SendPushMobile = functions.firestore
	.document('users/{uid}/notifications/{id}')
	.onWrite(async(change, context) => {
		const uid = context.params.uid;
		console.log(uid);
		const title = change.after.get('date');
		const content = change.after.get('alert');
		let userDoc = await admin.firestore().doc(`users/${uid}`).get();
		const email = userDoc.get('email');
		console.log(email);
		const fcmToken = userDoc.get('deviceToken');

		var message = {
			notification: {
				title: title,
				body: content,
			},
			token: fcmToken
		};

		let response = await admin.messaging().send(message);
		console.log(response);

});

