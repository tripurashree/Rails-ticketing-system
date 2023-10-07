# Rails Tickets System

Welcome to the Rails Tickets System, a ticketing system built on the Ruby on Rails framework. This system allows users to seamlessly book train tickets, manage their bookings, and provide valuable feedback on train services.

## Hosted Image
http://152.7.176.228:8080/

## Admin Credentials
- **Email:** admin@gmail.com
- **Password:** Admin@1234

## User Roles

### 1) Admin
- After logging in, the admin is directed to the home page.
- Home page features include:
  - View all passengers' profiles.
  - Update passenger profiles (excluding usernames).
  - View all trains and add new trains.
  - View tickets and book new tickets.
  - View reviews given by passengers and add new reviews.
  - See the passengers of a specific train.
- Admins cannot delete their own accounts.

### 2) Passenger
- After creating an account, passengers are directed to the home page.
- Home page features include:
  - Update passenger profile.
  - View a list of available trains.
  - Book tickets, view bookings, and give reviews.

## Core Features

### Train Booking
- **View Trains:** Users can browse and filter available trains based on arrival and departure stations and train ratings.
- **Book Tickets:** Efficient and user-friendly booking process.

### View Bookings
- Users can view their bookings with details such as Train Number, Departure Station, Termination Station, Departure Date, Arrival Date, ratings, etc.
- Users can cancel their bookings.

### User Management
- **User Registration and Login:** Secure registration and login process.
- **Edit Profile:** Users can edit their profiles.
- **Delete Account:** Users have the option to delete their accounts.

### Feedback and Reviews
- **Provide Feedback and Ratings:** Users can provide feedback and ratings after booking a train.
- **View Reviews:** Users can view reviews by other passengers, filtered by username or train number.
- **Edit Reviews:** Users can edit their own reviews.

## Admin Privileges
- **Admin Dashboard:** Access to a dashboard to manage users, train data, bookings, and reviews.
- **CRUD Operations:** Admins can create, read, update, and delete records related to trains, user profiles, bookings, and reviews.

## Technology Stack
- Ruby on Rails framework.
- Devise gem for authentication and session management.
- Cancancan gem for authorization.
- UI implementation using HTML and CSS.

## Getting Started
1. **User Registration:** Sign up for an account to access the system.
2. **User Login:** Log in to your account.
3. **Explore Trains:** Browse available trains, filter by date and time, and select your journey.
4. **Book Tickets:** Book and cancel tickets as needed.
5. **Provide Feedback:** Share your feedback and ratings after your journey.
6. **Profile Management:** Edit your profile information.

**Admin Access:** If you are an admin, access the admin credentials to manage the system.

## Screenshot

<img width="485" alt="ss 6" src="https://media.github.ncsu.edu/user/30678/files/cf3efe01-efc6-44a0-ba86-bfc7b7ce54cf">
<img width="514" alt="ss4" src="https://media.github.ncsu.edu/user/30678/files/4ef58a5e-5187-451e-95f3-737f08c45b52">
<img width="960" alt="ss3" src="https://media.github.ncsu.edu/user/30678/files/17b3383b-04fa-4bbc-879d-d1dc5ae0964d">
<img width="956" alt="ss 1" src="https://media.github.ncsu.edu/user/30678/files/be2043ed-f948-4a33-9dbb-e7351c0574ab">
<img width="956" alt="ss2" src="https://media.github.ncsu.edu/user/30678/files/07eeed0e-0c1f-4ccd-9985-31a32cf4ca5c">
<img width="960" alt="ss5" src="https://media.github.ncsu.edu/user/30678/files/823f844b-6b59-46a4-afc3-ae644f3a1ad6">

