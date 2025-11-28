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
    $title = "userForm";

    include 'header.php';
  ?>

  <main>
    <form>
        <fieldset>
            <p>
                <label for="txtFName">First Name: </label>
                <input type="text" id="txtFName" name="txtFName" placeholder="first name" value = "" required>
            </p>
            <p>
                <label for="txtLName">Last Name:</label>
                <input type="text" id="txtLName" name="txtLName" placeholder="last name" value = "" required>
            </p>
            <p>
                <label for="txtEmail">Email:</label>
                <input type="text" id="txtEmail" name="txtEmail" placeholder="netID@uvm.edu" value = "" required>
            </p>
            <label for="accesslvl">Choose a user access level:</label>
            <select name="accesslvl" id="accesslvl">
                <option value="student">Student</option>
                <option value="preceptor">Preceptor</option>
                <option value="admin">Administrator</option>
            </select>
        </fieldset>
        <fieldset id="submit">
            <button id="submitBtn" type="submit">Submit</button>
        </fieldset>
    </form>
  </main>

  <script type="module" src="scripts/firebase.js"></script>
  <script type="module" src="scripts/userEdit.js"></script>
</body>
</html>
