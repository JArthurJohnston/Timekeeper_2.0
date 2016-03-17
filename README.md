Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### Using the API

Some example code for making a login request to the api.
Upon a successful login, you will recieve a Json Web Token (JWT).

```javascript
    var creds = {credentials: {
    	username:"TTOD", password: "1234"
    }};
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
    if (xhttp.readyState == 4 && xhttp.status == 200) {
    	alert(xhttp.responseText);
    };
    xhttp.open("POST", "http://localhost:3000/api/user/login/");
    xhttp.setRequestHeader("Content-type", "application/json");
    xhttp.send(JSON.stringify(creds));
```

Note: Its recommended that you send any date information using the UTC timezone.
You can do this by calling the toUTCString function on any date object, before you serialize it.

For example:

```javascript
    var utcDate = todaysDate.toUTCString();

    xhttp.send(JSON.stringify(utcDate));
```