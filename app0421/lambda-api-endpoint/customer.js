const AWS = require('aws-sdk');
const s3 = new AWS.S3();
const Joi = require('joi'); //Require Joi for input validation

// Defining customer validation schema
const schema = Joi.object({
    customer_id: Joi.string().required(),
    first_name: Joi.string().required(),
    last_name: Joi.string().required(),
    email: Joi.string().email().required(),
    phone_number: Joi.string().required(),
    address: Joi.string().required(),
    city: Joi.string().required(),
    state: Joi.string().required(),
    zipcode: Joi.string().required(),
    created_at: Joi.date().iso().required()
});

exports.handler = async (event) => {
    try {
        // Validate and Parse the incoming JSON from the event object
        const validation = schema.validate(JSON.parse(event.body));
        
        // Throw an error in case of invalid input
        if (validation.error) throw validation.error;
        
        const customerDetails = validation.value;
        
        // Prepare the parameters for storing the data in S3
        const params = {
            Bucket: process.env.BUCKET_NAME, // Fetch bucket name from environment variable
            Body: JSON.stringify(customerDetails)
        };
        
        // Put the customer details in S3
        const data = await s3.putObject(params).promise();
        
        // Return success response
        return {
            statusCode: 200,
            body: JSON.stringify({
                message: 'Customer details stored in S3 successfully',
                data: data
            })
        };
    } catch (err) {
        console.error(err); // Log the error for debugging

        // Define a helpful error message
        let errMsg = 'An unknown error occurred storing customer details in S3';
        if (err.isJoi) errMsg = 'Invalid input data';
        if (err.code === 'NoSuchBucket') errMsg = 'The specified bucket does not exist';

        // Return error response
        return {
            statusCode: 500,
            body: JSON.stringify({
                message: errMsg,
                error: err.message
            })
        };
    }
};
