const { DynamoDBClient, PutItemCommand } = require("@aws-sdk/client-dynamodb");
const { marshall } = require("@aws-sdk/util-dynamodb");
const {
  randUuid,
  randEmail,
  randFullName,
  randUserName,
  randBoolean,
  randParagraph
} = require("@ngneat/falso");

const client = new DynamoDBClient({
  region: process.env.AWS_REGION || "eu-central-1"
});

exports.handler = async (event) => {
  console.log(JSON.stringify(event));

  try {
    for (let i = 0; i < event.createUsersNumber; i++) {
      const userId = randUuid();

      await client.send(
        new PutItemCommand({
          TableName: process.env.DYNAMODB_TABLE_NAME,
          Item: marshall({
            pk: userId,
            sk: "USERDATA",
            fullname: randFullName(),
            email: randEmail(),
            username: randUserName(),
            active: randBoolean(),
            createdAt: Date.now(),
          })
        })
      );

      for (let j = 0; j < event.createCommentsNumber; j++) {
        await client.send(
          new PutItemCommand({
            TableName: process.env.DYNAMODB_TABLE_NAME,
            Item: marshall({
              pk: userId,
              sk: `USERCOMMENT_${randUuid()}`,
              createdAt: Date.now(),
              comment: randParagraph()
            })
          })
        );
      }
    }

    const message = `${event.createUsersNumber} users and ${event.createCommentsNumber} users comments for each user have been inserted successfully`;

    console.log(message);

    return message;
  } catch (e) {
    console.log(e);
    throw new Error(e.message);
  }
};
