<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Resources - OBGYN Clerkship</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <!-- Header with Navbar -->
  <?php
    $title = "resources";

    include 'header.php';
  ?>

  <!-- Main Content -->
  <main>
    <h2>Resources</h2>

    <div class="section">
      <h3>Upload Resources</h3>

      <!-- Form for files or typed messages -->
      <form id="resource-form">
        <label for="resource-file">Upload file (PDF, image, etc.):</label><br>
        <input type="file" id="resource-file" name="resource-file" multiple><br><br>

        <label for="resource-text">Or type a message:</label><br>
        <textarea id="resource-text" name="resource-text" rows="4" cols="50" placeholder="Type your message here..."></textarea><br><br>

        <button type="submit">Upload</button>
      </form>

      <!-- Display uploaded resources -->
      <h3>Uploaded Resources:</h3>
      <ul id="uploaded-resources"></ul>
    </div>
  </main>
  <script type="module" src="scripts/resources.js"></script>
</body>
</html>

