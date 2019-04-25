# README

How the URL shortener works.


This rails 5 URL shortener consists of 3 endpoints that allow the react app: www.cuturl.work to fetch and post data into the systems DB.

- /top.json ( For the top 100 URLS)
 This endpoint consists of a query that limits results to 100 and makes sure that we pull only records that have a "hit" count greater than 0.  The response object is an array of arrays containing the necessary data that the ReactJS app table will be displaying, the url hash and the hit count.
 
 
 - /url.json
  This is a POST endpoint that receive a single parameters: "url".
 This is basically the url that the end user will be submitting into the input box and therefore will be sent to Rails to process it and create a short hash. 

The hashing algorithm chosen was the one similar to Reddit's post and TinyURL's shortening algorithm. To make sure that a url is always unique we use the new URL record's id, stringify it and convert it to a base36 string, afterwards an automatically random generated short hex is appended to it to make sure the new hashes are not easily guessed. 

The endpoint's response object is a json with a single key caled : short_url that the ReactAPP uses to showcase to the end user.

- /:short_hash

 This is a GET endpoint that looks for an existing record in the database, it basically looks for the param[:short_hash]
in the database and if it exists it will return a json with a single key called: "long_url" that the reactAPP uses for redirecting the end user.  

This API was testing driven developed using RSpec, every method developed has its respective spec.

As suggested, the database chosen for this scenario is a Postgresql simply for convienience as this is my database of choice for quick development projects.

