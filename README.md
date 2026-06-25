Student Assistant Application System

A mobile application built with Flutter and Dart that manages Student Assistant
applications for the Information Technology Department at the Central University
of Technology. The system allows students to apply for Student Assistant positions
and enables administrators to review, approve, or reject those applications.


Screenshots


1. Features

Student Portal
- Secure login and registration via Supabase Authentication
- Role-based routing — students and admins are directed to separate interfaces after login
- Submit a Student Assistant application for up to two modules
- View application status in real time (pending, approved, rejected)
- Edit or delete a pending application
- Upload supporting documentation


Admin Portal:
- View all submitted applications across all students
- Review applicant details and uploaded documents
- Approve or reject applications and update their status
- Remove invalid or incomplete applications
- Restricted access — only accessible to authorised admin users

Tech Stack
Framework -    Flutter
Language -     Dart
Backend/Auth - Supabase
Database -     Supabase PostgreSQL
File Storage - Supabase Storage
State Management - Provider
Architecture - MVVM
Version Control - GitHub


Architecture
The application follows the MVVM (Model-View-ViewModel) pattern:
1. Model — data classes and Supabase service calls
2. ViewModel — business logic, state management via Provider
3. View — Flutter UI screens that listen to ViewModel state
This separation keeps the UI layer clean and makes the logic independently testable.

Key Concepts Applied
Authentication — Supabase Auth handles login, session management, and role verification
CRUD — Full create, read, update, and delete operations on application records
Form handling — Validated forms with controlled input to prevent invalid submissions
Navigation — Named routes with role-based redirection after login
State management — Provider notifies the UI when application state changes
File storage — Supporting documents uploaded to Supabase Storage buckets



Contributors
Nhlanhlayethu Mazibuko 222044762 
A.L Hadebe 223000608 
K Mohlolo 220013730
N Shabalala 222034858
N.S Moloi 221034407
T Phage 224073145


License
This project was developed as part of an academic assignment at the
Central University of Technology. Not intended for commercial use.
