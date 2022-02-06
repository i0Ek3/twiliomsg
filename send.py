import os
from twilio.rest import Client

account_sid = os.environ['TWILIO_ACCOUNT_SID']
auth_token = os.environ['TWILIO_AUTH_TOKEN']
client = Client(account_sid, auth_token)

# Please change follows number to your own
BODY="This is a test."
FROM='+12132832283'
TO='+12132832283'

message = client.messages \
                .create(
                     body=BODY,
                     from_=FROM,
                     to=TO
                 )

print(message.sid)

