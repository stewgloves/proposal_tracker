# Proposal Tracker

![Proposal Tracker Logo](path_to_logo_image) *(Replace with your logo)*

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
    - [Configuration](#configuration)
- [Usage](#usage)
- [Testing](#testing)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Overview

**Proposal Tracker** is a robust Rails application designed to help organizations manage and track proposals efficiently. It offers comprehensive features such as user authentication, role-based authorization, proposal workflow management, Slack integration for notifications, document uploads, project-based tracking, real-time activity logs, and insightful dashboards. Tailwind CSS ensures a modern and responsive user interface, while RSpec provides a solid foundation for testing.

## Features

- **User Authentication:** Secure sign-up, login, and logout functionalities using Devise.
- **Role-Based Authorization:** Define user roles (e.g., Admin, User) with Pundit for access control.
- **Proposal Workflow Management:** Manage proposal statuses (Accepted, Under Review, Approved, Rejected, Scheduled) using AASM.
- **Slack Integration:** Receive notifications and approve/reject proposals directly from Slack.
- **Document Uploads:** Attach and manage documents related to proposals using Active Storage.
- **Project-Based Tracking:** Organize proposals under specific projects.
- **Responsive Design:** Modern UI built with Tailwind CSS for optimal user experience across devices.
- **Search and Filtering:** Efficiently search and filter proposals using Ransack.
- **Pagination:** Navigate through large datasets smoothly with Kaminari.
- **Comments:** Collaborate by adding comments to proposals.
- **Activity Logs:** Track changes and activities on proposals with PaperTrail.
- **Dashboard:** Gain insights with key metrics and charts using Chartkick.
- **Data Export:** Export proposals data in CSV format for reporting and analysis.

## Technologies Used

- **Backend:** Ruby on Rails
- **Database:** PostgreSQL
- **Authentication:** Devise
- **Authorization:** Pundit
- **State Management:** AASM
- **Background Jobs:** Sidekiq
- **File Uploads:** Active Storage
- **Styling:** Tailwind CSS
- **Testing:** RSpec
- **Search:** Ransack
- **Pagination:** Kaminari
- **Comments:** ActsAsCommentableWithThreading
- **Activity Logs:** PaperTrail
- **Charts:** Chartkick, Groupdate
- **Scheduling:** Whenever
- **Slack Integration:** slack-ruby-client

## Getting Started

Follow these instructions to set up the project locally.

### Prerequisites

Ensure you have the following installed on your machine:

- **Ruby:** Version 3.0.0 or higher
- **Rails:** Version 7.0 or higher
- **PostgreSQL:** For the database
- **Node.js & Yarn:** For managing JavaScript dependencies
- **Redis:** For Sidekiq background job processing
- **Git:** For version control

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/your_username/proposal_tracker.git
   cd proposal_tracker
   ```
Install Dependencies

Ensure you have Bundler installed:

```bash
Copy code
gem install bundler
bundle install
Set Up Database
```
Configure Database Credentials

Update config/database.yml with your PostgreSQL username and password.

Create and Migrate Database

```bash
rails db:create
rails db:migrate
Set Up Environment Variables

Create a .env file in the root directory and add the following variables:

env
```

```
SLACK_BOT_TOKEN=your_slack_bot_token
REDIS_URL=redis://localhost:6379/0
(Replace your_slack_bot_token with your actual Slack bot token.)
```

```bash
rails generate rspec:install
Seed the Database (Optional)
```

Populate the database with initial data:

```bash
rails db:seed
Configuration
```
### Slack Integration:

Ensure your Slack app is configured with the correct request URLs and event subscriptions.
Update Slack channels in the Proposal model and SlackNotifier service as needed.
Sidekiq:

Ensure Redis is running.

Start Sidekiq in a separate terminal:

```bash
bundle exec sidekiq
Background Job Scheduling:
```
Use Whenever to manage cron jobs.

Update the config/schedule.rb file as needed.

Update crontab:

```bash
bundle exec whenever --update-crontab
Usage
Start the Rails Server
```
```bash
rails server
````
### Access the Application

Visit http://localhost:3000 in your web browser.

### Sign Up and Log In

Create a new account or log in using existing credentials.
Admin users can manage all aspects of proposals and projects.
#### Managing Proposals

Create, view, edit, and delete proposals.
Upload relevant documents.
Submit proposals for review, approve, reject, or schedule them.
Collaborate with Comments

Add comments to proposals for collaboration and discussion.
#### View Activity Logs

Track changes and activities on each proposal through the activity log.
#### Dashboard Insights

Access the dashboard to view key metrics, recent proposals, and proposal trends.
#### Export Data

Export proposals data in CSV format for reporting and analysis.
### Testing
Run the test suite using RSpec to ensure application integrity.

```bash
bundle exec rspec
Note: Ensure all dependencies are installed and the test database is set up.
```

### Deployment
Deploy the application to your preferred hosting platform. Below are general steps, but specifics may vary based on the platform (e.g., Heroku, AWS, DigitalOcean).

#### Prepare for Deployment

Ensure environment variables are set on the production server.
Configure production database settings in config/database.yml.
#### Set Up Active Storage

Configure a cloud storage service (e.g., Amazon S3) for production.
#### Precompile Assets

```bash
rails assets:precompile RAILS_ENV=production
Run Migrations on Production
```
```bash
rails db:migrate RAILS_ENV=production
```

### Contributing
Contributions are welcome! Follow these steps to contribute to the project:

Fork the Repository

Create a Feature Branch

```bash
git checkout -b feature/YourFeatureName
Commit Your Changes
```
```bash
git commit -m "Add Your Feature"
Push to the Branch
```
```bash
git push origin feature/YourFeatureName
Open a Pull Request
```

### License
This project is licensed under the MIT License.

### Contact
For any inquiries or support, please contact:

Name: Stewart Glover

---