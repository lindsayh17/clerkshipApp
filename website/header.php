<header>
    <?php $pathParts = pathinfo($_SERVER['PHP_SELF']); ?>

    <div class="header-left">
      <img src="UVM recolored logo.jpg" alt="UVM Logo" class="logo">
      <h1>OBGYN Clerkship</h1>
    </div>
    <nav>
      <a href="dailyQuestion.php" class="nav-link <?php
        if ($pathParts['filename'] == "dailyQuestion") {
            print 'active';
        }
        ?>">Daily Questions</a>
      <a href="userPermissions.php" class="nav-link <?php
        if ($pathParts['filename'] == "userPermissions") {
            print 'active';
        }
        ?>">Users</a>
      <a href="evaluations.php" class="nav-link <?php
        if ($pathParts['filename'] == "evaluations") {
            print 'active';
        }
        ?>">Evaluations</a>
    </nav>
</header>