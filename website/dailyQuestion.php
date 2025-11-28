<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Profile - OBGYN Clerkship</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <?php
    $title = "dailyQuestion";

    include 'header.php';
  ?>

  <main>
    <h2>Add a daily question: </h2>
    <form>
        <fieldset>
            <p>
                <label for="txtQuestion">Question: </label>
                <input type="text" id="txtQuestion" name="txtQuestion" placeholder="Question Text" value = "" required>
            </p>
            <p>
                <label for="txtAnswer">Answer:</label>
                <input type="text" id="txtAnswer" name="txtAnswer" placeholder="Correct Answer" value = "" required>
            </p>
        </fieldset>
        <fieldset id="submit">
            <button id="submitBtn" type="submit">Submit</button>
        </fieldset>
    </form>
  </main>

  <script type="module" src="scripts/firebase.js"></script>
  <script type="module" src="scripts/questions.js"></script>
</body>
</html>
