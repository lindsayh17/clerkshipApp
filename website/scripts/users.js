import { db } from "./firebase.js";
import { doc, collection, query, where, getDocs, deleteDoc } from "https://www.gstatic.com/firebasejs/10.12.3/firebase-firestore.js";

const q = query(collection(db, "Users"));
const tableBody = document.querySelector("#users-table tbody");

// Delete user
let modal = document.getElementById('deleteModal');
let closeBtn = document.getElementById('closeBtn');
let confirmBtn = document.getElementById('confirmBtn');
let userToDelete = null;

confirmBtn.addEventListener('click', function() {
  deleteUser(userToDelete);
  modal.style.display = 'none';
});
closeBtn.addEventListener('click', function() {
  modal.style.display = 'none';
});

  // Close modal if clicked out of it
window.addEventListener('click', function(event) {
  if (event.target === modal) {
    modal.style.display = 'none';
  }
});

const querySnapshot = await getDocs(q);
querySnapshot.forEach((doc) => {
  // doc.data() is never undefined for query doc snapshots
  console.log(doc.id, " => ", doc.data());

  // print users
  let data = doc.data();
  let firstName = data.firstName
  let lastName = data.lastName
  let email = data.email
  let access = data.access

  let row = document.createElement("tr");

  // Create cells for each field
  let firstCell = document.createElement("td");
  firstCell.textContent = firstName;

  let lastCell = document.createElement("td");
  lastCell.textContent = lastName;

  let emailCell = document.createElement("td");
  emailCell.textContent = email;

  let accessCell = document.createElement("td");
  accessCell.textContent = access;

  let actionCell = document.createElement("td");
  let editlink = document.createElement('a');
  editlink.href = `userForm.php?id=${doc.id}`;
  editlink.textContent = 'Edit'
  editlink.classList.add('editButton', 'actionButton');
  actionCell.appendChild(editlink)

  let deleteButton = document.createElement('button');
  deleteButton.textContent = 'Delete User';
  deleteButton.classList.add('deleteButton', 'actionButton');
  actionCell.appendChild(deleteButton)

  deleteButton.addEventListener('click', function() {
    modal.style.display = 'block';
    userToDelete = doc.id;
  });

  row.appendChild(firstCell);
  row.appendChild(lastCell);
  row.appendChild(emailCell);
  row.appendChild(accessCell);
  row.appendChild(actionCell);

  console.log("Row:", row);

  tableBody.appendChild(row);
});

async function deleteUser(id){
  console.log("Deleting user with ID: " + id);
  try {
    await deleteDoc(doc(db, "Users", id));
    console.log("User deleted successfully.");
  } catch (error) {
    console.error("Error deleting user: ", error);
  }
}