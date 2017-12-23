# README
This project was developed under the course of Object Oriented Design and Development.

-In the cars page, Hit search button on empty search boxes to see the list of all cars.

-If you can not see cars then add cars using superadmin login

-We have used to devise gem to handle users, thus you will not see a lot of code in the user controllers. This gem creates a lot of different controllers for users which have not been used by us as yet. 

-The user/registrations_controller has been overridden by the registraions_controller to add extra attributes to uses and for personalization. 


Users :
= A user can search for car from Dashboard -> 'Search Cars'. All the attributes of the car are displayed in table.
= He can search car using location, model and manufacturer. Car availability is shown in the table. If a car is reserved the user can still book the car for another checkout time.
= Overlap in reservation time is handled by the Application. 

= **When a car is reserved the current booking is shown on the dashboard with all the options. 'checkout', 'cancel booking', 'checkin'. These options are not displayed if no car is currently reserved by the user. 
= A user can cancel the booking only before checkout time. The user can checkin the car only if the car is checkedout. 
= The reservation will expire if the car is not checkedout within 30mins from checkout time specified.**

= if a car is checked out it can not be destroyed. 

= when a car that is not yet returned is deleted -> system wont allow this

= checkout history of a user when one of the cars (s)he once checked out is deleted -> this reservation wont be shown in the checkout history in that case.

= If a user has a reservation, then the user can not be deleted.

= A user can check his checkout history from the Dashboard -> Past Reservations. This will show all the list of reservations made by user.


ADMIN FUNCTIONALITY
 
 
Managing Users:
= Admin can view users from Dashboard -> "Manage Users". Admin can only view Users and other Admins. While a superadmin can view Uses, Admin and all Superadmins.
= admin can add users and admins from Dashboard -> "Manage Users" -> "Add Users" -> select user type (Admin or User)
= admin can check user/Admin details by Dashboard -> "Manage Users" -> "Show"

Special case : User Deletion:
= Admin can delete a user by going to 'Manage Users' -> 'Destroy'. 
= **If the user has active reservation it cant be deleted.** 
= **Once a user is deleted the 'Manage reservations' will not show the reservations of the deleted user.**

Admin on behalf of user:
= Admin can checkout a car for user from Dashboard -> "Manage Reservations" -> "checkout for user" ( only available when there is an active reservation)
= Admin can checkin a car for user from Dashboard -> "Manage Reservations" -> "checkin for user" ( only available when there is an active reservation)
= Admin can cancel a booking for user from Dashboard -> "Manage Reservations" -> "cancel reservation" ( only available when there is an active reservation)

= Admin can delete other admins from Manage Users' -> 'Destroy'. Admin can delete only other admins not himself.

= Admin can view reservations of specific user from Dashboard -> "Manage Users" -> "history". This will show all reservations of the user. Active reservation will show "Current"  

= Admin can view all reservations from Dashboard -> "Manage Reservations"

Special case : CAR DELETION: 
= Admin can delete a car, from Dashboard -> Manage Cars -> Destroy only if it is **AVAILABLE**
= **Admin can not delete a car which is already reserved. Dashboard -> Manage Cars -> Destroy  will show 'Car is reserved. Cant be destroyed'**
= **Admin can not delete a car which is already checkedout. Dashboard -> Manage Cars -> Destroy will show 'Car is checkedout. Cant be destroyed'**
= **if admin deletes a car, past reservations will show 'car not available'**


**Notifications:** 
**= A user who does not have an active booking will see an option of "Notify Availability" against all Reserved or Checkedout Cars.**

**Suggestions:**
**= User can suggest a car from Dashboard -> 'Suggest A Car'.**
**= Admin can approve suggestions by making edits and adding details like license, rate and Status**
