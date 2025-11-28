<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>OBGYN Clerkship Dashboard</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <!-- Header with Top Navbar -->
  <?php
    $title = "index";

    include 'header.php';
  ?>

  <!-- Main Content -->
  <main>
    <h2>Welcome to the OBGYN Clerkship Dashboard</h2>
    <p>Select a tab above to navigate to Resources, Profile, User Permissions, or Student Grades.</p>
  </main>

</body>
</html>

  <script>
    // Tab functionality
    const tabs = document.querySelectorAll('.nav-btn');
    const contents = document.querySelectorAll('.tab-content');

    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        const target = tab.dataset.tab;

        contents.forEach(c => c.classList.remove('active'));
        document.getElementById(target).classList.add('active');
      });
    });
  </script>
</body>
</html>
