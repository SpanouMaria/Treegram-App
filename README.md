<div align="center">
  <img src="https://img.shields.io/github/last-commit/ChristosGkovaris/Treegram-App?color=91c4b3&style=flat&label=Last%20Commit" />
</div>




# TREEGRAM APP

This project implements a **photo-sharing social media application** using **Ruby on Rails**,  
with support for **user accounts, photo uploads, comments, following system, and dynamic features**  
such as **slide-show viewing** and **AJAX-powered pop-up comments**. It was developed as part of
the **MYE042 – Τεχνολογίες Διαδικτύου** course at the **University of Ioannina**.

---

## TABLE OF CONTENTS
1. [Overview](#overview)
2. [Features](#features)
3. [Project Structure](#project-structure)
4. [Input Data](#input-data)
5. [Algorithms Implemented](#algorithms-implemented)
6. [Installation](#installation)
7. [Usage](#usage)
8. [Output Files](#output-files)
9. [Testing](#testing)
10. [License](#license)
11. [Contact](#contact)

---

## OVERVIEW

**Treegram App** is a web-based **photo-sharing platform** where users can:  
- **Register and log in**,  
- **Upload and manage photos**,  
- **Follow other users**,  
- **Add and delete comments**,  
- **View followed users’ photos in reverse chronological order**.

The application was later extended to include:  
- **Slide-show photo viewing** for followed users,  
- **AJAX-powered pop-up windows** for viewing and adding comments dynamically.

These features provide a **modern, interactive user experience** while maintaining a **clean Ruby on Rails structure**.

---

## FEATURES

- **User Authentication**
  - Sign up, log in, and secure session management  
- **Photo Management**
  - Upload photos with **titles**  
  - Delete own photos along with all comments and tags
- **Comments System**
  - Add and delete comments with **permission rules**
- **Follow/Unfollow Users**
  - View photos from followed users in **reverse chronological order**
- **Slide-Show Mode**
  - Hovering over a user’s photo starts a **dynamic slideshow** of their photos
- **AJAX Pop-Up Comments**
  - Click a photo to view recent comments and add a new one without leaving the page

---

## PROJECT STRUCTURE

```
treegram-app/
│── README.md
│
├── docs/
│   ├── photo sharing.pdf           # Assignment 1 – Photo Sharing
│   └── slide show.pdf              # Assignment 2 – Slide Show & Pop-up
│
├── src/                            # Optional folder for additional scripts or helpers
│
├── app/
│   ├── controllers/                # Rails controllers
│   ├── models/                     # User, Photo, Comment, Follow models
│   ├── views/                      # HAML/ERB templates
│   └── assets/                     # Images, JavaScript, and CSS
│       ├── images/
│       ├── javascripts/
│       └── stylesheets/
│
├── bin/                            # Rails executables
├── config/                         # Configuration files for the Rails app
├── db/                             # Database migrations and schema
├── public/                         # Public assets
├── spec/                           # Tests (not implemented)
│
├── Gemfile
├── Gemfile.lock
├── Rakefile
├── config.ru
└── README.md                       # This file
```

---

## INPUT DATA

- **User Accounts** – Created via registration form (email, password)  
- **Photos** – Uploaded images with **titles** and optional **tags**  
- **Comments** – Text comments associated with photos  
- **Follow Relationships** – Each user can follow or unfollow others

---

## ALGORITHMS IMPLEMENTED

1. **Follow System & Feed Generation**
   - Retrieves photos of the user and followed users
   - Sorts feed in **reverse chronological order**

2. **Slide Show Feature**
   - **JavaScript/jQuery** creates a timed slideshow on hover
   - Stops when mouse leaves the photo container

3. **AJAX Pop-Up Comments**
   - Loads comments into a **dynamic modal** via AJAX
   - Supports **adding a new comment** without reloading the page

---

## INSTALLATION

1. **Clone the repository:**
```bash
git clone https://github.com/ChristosGkovaris/Treegram-App.git
cd Treegram-App
```

2. **Install Ruby (>= 2.6.6) and Rails (>= 6)**  
3. **Install dependencies:**
```bash
bundle install
```

4. **Setup the database:**
```bash
rails db:migrate
```

5. **Run the server:**
```bash
rails server
```

---

## USAGE

1. Open a browser and navigate to:
```
http://localhost:3000
```
2. **Register a new account** and **log in**  
3. **Upload photos**, **follow users**, **add comments**  
4. Hover over a photo to **start the slideshow**  
5. Click a photo to **view and add comments via pop-up**

---

## OUTPUT FILES

- **Uploaded Photos:** Stored in `app/assets/images`  
- **Database:** SQLite3 local development database  
- **Optional Logs:** Rails logs in `log/development.log`

---

## TESTING

- Verify user registration, login, and logout  
- Test uploading and deleting photos  
- Ensure comment permissions work as expected  
- Hover over a user’s photo to trigger the slideshow  
- Click a photo to open the AJAX pop-up and add comments dynamically

---

## LICENSE

This project is licensed under the **MIT License**.  

- Original Authors: Kathryn Carr, J Sivakumaran, Lizzie Koehler  
- Modified for educational purposes by: S. Anastasiadis & A. Katsoulieris (University of Ioannina, MYE042)  
- Further modifications by: Christos Gkovaris  

See the [LICENSE](LICENSE) file for details.

---

## CONTACT

**Christos-Grigorios Gkovaris**  
University of Ioannina – Computer Science and Engineering  
[GitHub](https://github.com/ChristosGkovaris)

**Maria Spanou**  
University of Ioannina – Computer Science and Engineering  
[GitHub](https://github.com/SpanouMaria)
