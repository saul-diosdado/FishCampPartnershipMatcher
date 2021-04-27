# README

##  Executing The Application
The following instructions will clone this application and install the necessary dependencies.
```bash
git clone https://github.com/saul-diosdado/FishCampPartnershipMatcher.git
cd FishCampPartnershipMatcher
bundle install
```
Next, to run an instance of the application locally...
```bash
rails s
```

## Dependencies, Tools, and Gems

### Packages and Tools
* Ruby 2.7.2 
* Rails 6.1.2 
* Bootstrap 4.6.0 – for styling purposes 
* jQuery-rails 4.4.0 – for use in the creation of questions 
* rspec-rails 4.0.2 – for creating unit, integration, and acceptance tests 
* Heroku 
* PostgreSQL 
* RuboCop – for enforcing the coding standard and automatically correcting offenses 
* SimpleCov– for seeing code coverage of the tests created. 
* Brakeman– for detecting vulnerabilities/security threats. 

### Gems
* Cocoon – used in the Questions functionality. This gem facilitates adding multiple answer choices to a question (through associations between the Question and Choice model), as well as provides functionality for easy UI that is intuitive to the user when they are adding/deleting answer choices. 
* Clearance – Used for sign up and sign in pages. Encrypts the users password so they are never stored as plaintext in the database and generated routes to make the login setup easier. 
* Administrate- Used to implement the admin dashboard. It allowed for the customization of the dashboard the way the customer wanted it.  

## Deploying To Heroku
For an existing Heroku application, the following command will setup a remote link to the Heroku app.
```bash
heroku git:remote -a <name-of-app>
```
Once the remote application has been configured, the following command will deploy the main branch of this repository to the Heroku.
```bash
git push heroku
```

## CI/CD
This repository has GitHub actions which will automatically run RuboCop and deploy to a Heroku application.
The following variables must be set in GitHub Secrets in order to correctly run the CI/CD. GitHub Seccrets are found
under Settings > Secrets in this repository.

```bash
HEROKU_API_KEY = <API key found in Heroku>
HEROKU_APP_NAME = <The name of the Heroku application>
HEROKU_EMAIL = <The email associated with the owner of the Heroku application>
RAILS_MASTER_SECRET = <Any arbitrary password for rails>
```

The RuboCop action will fail if any instance in the code violates the coding convention specified in the RuboCop configuration file.
Next, the GitHub action will attempt to build and deploy the application to the Heroku app specified under HEROKU_APP_NAME in the Secrets.

## Mailer and Email Confirmation
Our application 
We use a hidden application.yml file located in the config folder to store the mailer credentials, along with the URL of the website.

To change these parameters, simply put:

```bash
mailgun_user_name: 'fcpartnershipmatchermailer@gmail.com'
mailgun_password: '<password of the email>'
app_url: '<heroku app url>'
```

in the application.yml file. It is important to leave this application.yml to in the .gitignore as it stores sensitive information that should
not be public.

To get the credentials of the current mailer, plese contact our product manager Willie at: spriggswlle@gmail.com.
You are not required to use the same mailer email. However, you must provide the email and password to a valid email account.

## Administrator Account
In order to access the administrator account, sign up/log in using the administrator email: fcpartner123@gmail.com
When signing up: confirm email by logging in to the administrative Gmail account using the email above. Contact Director of Fish Camp for permission to access the account.
This account automatically has administrator privileges.

## Assigning Roles To Users
Users are automatically assigned as 'chair' role. To change the role of an existing user, first login using the administrator credentials.

### Assigning Director Role
Navigate to the 'Administrator Dashboard' > 'Roles' > 'Create Role' > in the name field: 'director'. Then navigate to the 'Users' tab, click on the user
you want to make a director. Under the role field, add 'director' and remove 'chair'. 

### Assigning Admin Role
You can also assign the administrator role to other users. We advise to only assign the administrator role to other directors. Login with an existing
administrator account, then navigate to the 'Users' tab, click on the user
you want to make a administrator. Under the role field, add 'admin'.

## Coding Standard Example
[Ruby Naming Conventions](https://gist.github.com/iangreenleaf/b206d09c587e8fc6399e)