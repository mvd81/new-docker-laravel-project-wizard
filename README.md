# New Docker Laravel Project Wizard
Wizard to setup a new Docker-compose file, startup the Docker containers and install the latest Laravel version.

## What It Does

When you call this (shell) script it will ask for:
* The project name to use as Docker network name, database + test database name
* A free Docker Nginx port number
* A free Docker PHP port number
* A free Docker Mysql port number

Then it will:
* Download my docker-compose file from repo, https://github.com/mvd81/docker-laravel
* Change the chosen values (network name + ports + (test) database name) in the docker-compose.yml + 
  sql_scripts/create_test_db.sql file
* Start the Docker containers
* Download + install the latest Laravel installation
* Give you some information how to update the database config + .env file
* Open the project in the browser
* remove the installation wizard file

## How I am using this

I download this file, and add some personal changes in the script.  
I will automatically create a 'staging' and 'production' directory to store the .env filers for example.

### Alias
I will make an alias (once)
```bash
alias newlaravel="cp C:/new-docker-laravel-project.sh . && sh new-docker-laravel-project.sh"
```

### Create a new project
Create a new directory somewhere and get into this new directory and call:  
```bash
newlaravel
```