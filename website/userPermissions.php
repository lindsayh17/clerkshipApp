<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Permissions - OBGYN Clerkship</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <?php
    $title = "userPermissions";

    include 'header.php';
  ?>

  <div id="deleteModal" class="modal">
    <div class="modal-content">
      <p>Are you sure you want to delete this user?</p>
      <button class="modal-button confirm-btn" id="confirmBtn">Yes, delete user</button>
      <button class="modal-button cancel-btn" id="closeBtn">No, keep user</button>
    </div>
  </div>

  <main>
    <h2>User Permissions</h2>
    <p>Manage user permissions here.</p>
    <table id="users-table">
    <thead>
      <tr>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Email</th>
        <th>Access Level</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <!-- Users will be printed here -->
    </tbody>
  </table>
  </main>

  <script type="module" src="scripts/firebase.js"></script>
  <script type="module" src="scripts/users.js"></script>
</body>
</html>
