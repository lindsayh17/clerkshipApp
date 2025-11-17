// Admin upload resources functionality
document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("resource-form");
  const resourceFileInput = document.getElementById("resource-file");
  const uploadedList = document.getElementById("uploaded-resources");

  form.addEventListener("submit", (e) => {
    e.preventDefault(); // prevent form from refreshing the page

    // Handle file uploads
    const files = resourceFileInput.files;
    for (let i = 0; i < files.length; i++) {
      const li = document.createElement("li");
      li.textContent = `File: ${files[i].name}`;
      uploadedList.appendChild(li);
    }

    // Handle typed message
    const textInput = document.getElementById("resource-text").value.trim();
    if (textInput) {
      const li = document.createElement("li");
      li.textContent = `Message: ${textInput}`;
      uploadedList.appendChild(li);
    }

    // Reset form
    form.reset();
  });
});