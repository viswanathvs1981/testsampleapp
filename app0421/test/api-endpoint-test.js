const assert = require('assert');
const axios = require('axios');
const nock = require('nock');

describe('API Endpoint Test', function() {
  // Prepare necessary variables for the test
  let response, mockCustomerData;

  before(function() {
    // Mock customer data to be sent to the API endpoint
    mockCustomerData = {
      name: 'John Doe',
      email: 'johndoe@example.com',
      phone: '1234567890',
      address: '123 Main St, City, Country',
    };
 
    // Use nock to mock the API endpoint
    nock('http://localhost:3000')
        .post('/customer', mockCustomerData)
        .reply(200, { status: 'success' });
  });
  
  it('should store customer information in S3 via the API endpoint', async function() {
    try {
      // Make a POST request to the API endpoint with customer data
      response = await axios.post('http://localhost:3000/customer', mockCustomerData);
      
      // Assert that the response status is 200 and respond with success message
      assert.strictEqual(response.status, 200);
      assert.strictEqual(response.data.status, 'success');
    } catch(error) {
      console.log('Error during the test execution:', error);
    }
  });

  after(function() {
    // Cleanup the mocked api endpoint
    nock.cleanAll();
  });

});