const { RekognitionClient, DetectFacesCommand } = require("@aws-sdk/client-rekognition");
const rekoClient = new RekognitionClient();

exports.handler = async (event) => {
    console.log(JSON.stringify(event));

    const bucketName = event.Records[0].s3.bucket.name;
    const objectName = event.Records[0].s3.object.key;

    const detectFacesCommand = new DetectFacesCommand({
        Image: {
            S3Object: {
                Bucket: bucketName,
                Name: objectName
            }
        },
        Attributes: ['ALL']
    });

    try {
        const response = await rekoClient.send(detectFacesCommand);
        console.log(JSON.stringify(response));
    } catch (e) {
        console.log(e);
        throw new Error(e.message);
    }
};
