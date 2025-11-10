// Navigation tabs
const navButtons = document.querySelectorAll(".nav-btn");
const tabContents = document.querySelectorAll(".tab-content");

navButtons.forEach(btn => {
  btn.addEventListener("click", () => {
    navButtons.forEach(b => b.classList.remove("active"));
    btn.classList.add("active");

    const target = btn.getAttribute("data-tab");
    tabContents.forEach(tab => {
      if(tab.id === target){
        tab.classList.add("active");
      } else {
        tab.classList.remove("active");
      }
    });
  });
});

// Admin upload resources
const uploadBtn = document.getElementById("upload-btn");
const resourceFileInput = document.getElementById("resource-file");
const uploadedList = document.getElementById("uploaded-resources");

uploadBtn.addEventListener("click", () => {
  const files = resourceFileInput.files;
  for(let i=0; i<files.length; i++){
    const li = document.createElement("li");
    li.textContent = files[i].name;
    uploadedList.appendChild(li);
  }
  resourceFileInput.value = ""; // reset input
});
