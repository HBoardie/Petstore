Feature: Pet
  In order to manage pet information
  As a store owner
  I need to be able to manipulate pets details in the online application

  Scenario: Test Case 1 - Add a new pet to the store
    Given the request body is:
  """
  {
    "id": 0,
    "category": {
      "id": 0,
      "name": "string"
    },
    "name": "doggie",
    "photoUrls": [
      "string"
    ],
    "tags": [
      {
        "id": 0,
        "name": "string"
      }
    ],
    "status": "available"
  }
  """
    When I request "/pet" using HTTP POST
    Then the response code is 200
    And the response body is
  """
  {
    "id": 0,
    "category": {
      "id": 0,
      "name": "string"
    },
    "name": "doggie",
    "photoUrls": [
      "string"
    ],
    "tags": [
      {
        "id": 0,
        "name": "string"
      }
    ],
    "status": "available"
  }
  """

  Scenario: Test case 2 - Add a new pet with invalid data - without name
    Given the request body is:
  """
  {
  "id": "aaa",
  "category": {
  "id": 0,
  },
  "name": null,
  "photoUrls": [
  4246
  ],
  "tags": [
  {
  "id": 2sad12,
  "name": "string"
  }
  ],
  "status": "bbb"
  }
  """
    When I request "/pet" using HTTP POST
    Then the response code is 405

  Scenario: Test Case 3 - Update an existing pet with valid data
    Given the request body is:
  """
  {
    "id": 0,
    "category": {
      "id": 0,
      "name": "string"
    },
    "name": "doggie",
    "photoUrls": [
      "string"
    ],
    "tags": [
      {
        "id": 0,
        "name": "string"
      }
    ],
    "status": "available"
  }
  """
    When I request "/pet" using HTTP PUT
    Then the response code is 200
      And the response body is
  """
  {
    "id": 0,
    "category": {
      "id": 0,
      "name": "string"
    },
    "name": "doggie",
    "photoUrls": [
      "string"
    ],
    "tags": [
      {
        "id": 0,
        "name": "string"
      }
    ],
    "status": "available"
  }
  """

  Scenario: Test Case 4 - Update an existing pet with invalid data - no data
    Given the request body is:
  """
  {
  }
  """
    When I request "/pet" using HTTP PUT
    Then the response code is 404


  Scenario: Test case 5: Find pets by status
    Given the request body contains "available"
    When I request "/pet/{petId}" using HTTP GET
    Then the response code is 200
      And the response body contains JSON:
  """
  {
      {
        "id": 0,
        "name": "string"
      }
    ],
    "status": "available"
  }

  """

   Scenario: Test Case 6 - Find pet with valid ID
    Given the request body is:
  """
  1
  """
    When I request "/pet/{petId}" using HTTP GET
    Then the response code is 200
      And the response body is
  """
   {
   "id": 0,
   "category": {
   "id": 0,
   "name": "string"
   },
   "name": "doggie",
   "photoUrls": [
   "string"
   ],
   "tags": [
   {
   "id": 0,
   "name": "string"
   }
   ],
   "status": "available"
   }
   """
  Scenario: Test Case 7 - Attempt to find pets with invalid ID
  """
  666
  """
    When I request "/pet/{petId}" using HTTP GET
    Then the response code is 404

  Scenario: Test case 8 - Update a pet in the store with valid form data
    Given the request body is:
"""
  {
    "id": 0,
    "category": {
      "id": 0,
      "name": "string"
    },
    "name": "doggie",
    "photoUrls": [
      "string"
    ],
    "tags": [
      {
        "id": 0,
        "name": "string"
      }
    ],
    "status": "available"
  }
  """
      And the following form parameters are set:
        |petId  |name     |status     |
        |0      |"doggie"  |"available"|
    When I request "/pet/{petId}" using HTTP POST
    Then the response code is 200
      And the response body is
  """
  {
    "id": 0,
    "name": "doggy",
    "status": "available"
  }
  """

  Scenario: Test Case 9 - Update a pet in the store with invalid form data
    Given the following form parameters are set:
      |petId  |name        |status   |
      |"500"  |"serbarus"  |"pending"|
    When I request "/pet/{petId}" using HTTP POST
    Then the response code is 404


  Scenario: Test Case 10: Delete a pet
    Given the pet is existing in the database
  """
  {
    "id": 0,
    "category": {
      "id": 0,
      "name": "string"
    },
    "name": "doggie",
    "photoUrls": [
      "string"
    ],
    "tags": [
      {
        "id": 0,
        "name": "string"
      }
    ],
    "status": "available"
  }
  """
    And the request body is:
  """
  {
    "api_key" : "valid api_key",
    "id": 1
  }
  """
    When I request "/pet/{petId}" using HTTP DELETE
    Then the response code is 200

  Scenario: Test case 11 -  Delete a pet with invalid data
    Given the request body is:
  """
  {
    "api_key" : "valid api_key",
    "id": "ppp"
  }
  """
    When I request "/pet/{petId}" using HTTP DELETE
    Then the response code is 400


  Scenario: Test case 12 - Upload an image
    Given the request body is:
  """
  {
    "petId": 0,
    "additionalMetadata": "",
    "file": "/home/hboardie/picture/neddy.jpg"
  }
  """
    When I request "/pet/{petId}/uploadImage" using HTTP POST
    Then the response code is 200
      And the response body is
  """
  {
    "petId": 0,
    "additionalMetadata": "",
    "file": "/home/hboardie/picture/neddy.jpg"
  }
  """

  Scenario: Test Case 13 - Upload and image with Unsupported Media Type
    Given the request body is:
  """
  {
    "petId": 0,
    "additionalMetadata": "",
    "file": "/home/hboardie/picture/neddy.png"
  }
  """
    When I request "/pet/{petId}/uploadImage" using HTTP POST
    Then the response code is 415
