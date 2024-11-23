Task Manager App

Overview
The Task Manager App allows users to manage their tasks efficiently. Users can create, update, delete, and view tasks. Each task is associated with a specific category, and the app provides functionality for filtering tasks by status, due date, and keyword search.

Features
User Authentication: Users can sign up, log in, and log out.
Task Management: Users can create, update, delete, and mark tasks as completed.
Task Categorization: Each task can be assigned to a specific category.
Search Functionality: Users can search tasks by keyword, category, and status.
Due Date Validation: Tasks must have a due date greater than or equal to today.
Task Status: Tasks can be marked with different statuses (pending, in progress, completed, incomplete).
Authorization: Users can only access, edit, or delete their own tasks.

Technologies Used
Ruby on Rails: Web framework used for building the application.
PostgreSQL: Database management system used to store data.
Capybara: Used for writing and running feature specs for testing.
RSpec: Used for unit and feature testing.
PgSearch: For implementing full-text search functionality.
Tailwind CSS: For styling the user interface.
Installation
Prerequisites
Make sure you have the following installed on your machine:

Ruby 3.x
Rails 7.x
PostgreSQL
Setup
Clone the repository:

bash
Copy code
git clone https://github.com/Ahsan118/Task-Managment-System.git
cd Task-Managment-System
Install the necessary gems:

bash
Copy code
bundle install
Set up the database:
Clone .env.example file 

bash
Copy code
rails db:create
rails db:migrate
rails db:seed
Start the Rails server:

bash
Copy code
rails server
Visit http://localhost:3000 in your browser.

Usage
Sign Up / Log In: Users need to sign up to access the task management features. After signing up, they can log in to their account.

Managing Tasks:

Users can create tasks by filling out a form that includes the task name, category, due date, status, and description.
Tasks can be updated, marked as completed, and deleted.
Tasks are categorized under specific categories, and users can filter tasks by status, category, and due date.
Search: Users can search for tasks by keyword using the search bar at the top of the page.

Security: Only the user who created a task can edit or delete it. If a user tries to access another user's task, they will be redirected.

Testing
The application is tested using RSpec for unit and feature testing, with Capybara for simulating browser interactions.

Running Tests
To run all tests:

bash
Copy code
rspec
Running Feature Specs
To run the feature specs (which include the task management workflows):

bash
Copy code
rspec spec/features
Contributing
Fork the repository.
Create a new branch (git checkout -b feature-name).
Commit your changes (git commit -am 'Add new feature').
Push to the branch (git push origin feature-name).
Create a new pull request.