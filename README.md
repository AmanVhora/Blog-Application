# Setting Up Blog Application

## Prerequisites
Before you begin, make sure you have the following tools and technologies installed on your machine:

Ruby version - 3.2.1    
Rails version - 7.0.7

## Clone Project
Clone the Repository using command:     
git clone https://github.com/AmanVhora/Blog-Application.git

Then Move into the project's directory using the command:       
cd repository-name

## Install Dependencies
Install the required gems using command:    
bundle install

## Set Up the Database
Database Configuration: Go to the config/database.yml file and provide your database credentials.

Database Setup: Run following commands.

rails db:create          # Create the database  
rails db:migrate         # Run migrations   
rails db:seed            # Seed the database with sample data

## Start the Application
Start application with command:     
rails s

Then open your web browser and go to http://localhost:3000 to access the application.
