const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.notifyAttendeesOnEventUpdate = functions.firestore
  .document('events/{eventId}')
  .onUpdate((change, context) => {
    const eventId = context.params.eventId;
    const updatedEventData = change.after.data();
    const eventName = updatedEventData.Event_Name;

    // Query the registrations for the updated event
    return admin.firestore().collection('event_registrations')
      .where('eventId', '==', eventId)
      .get()
      .then(snapshot => {
        const tokens = [];
        snapshot.forEach(doc => {
          const userToken = doc.data().fcmToken; // Assuming FCM tokens are stored
          if (userToken) {
            tokens.push(userToken);
          }
        });

        if (tokens.length > 0) {
          const payload = {
            notification: {
              title: 'Event Updated',
              body: `The event "${eventName}" has been updated. Please check.`,
            }
          };

          return admin.messaging().sendToDevice(tokens, payload);
        }
        return null;
      })
      .catch(err => console.error('Error sending notifications:', err));
  });
