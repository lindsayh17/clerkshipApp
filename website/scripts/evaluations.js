import { db } from "./firebase.js";
import {  collection, query, where, getDocs } from "https://www.gstatic.com/firebasejs/10.12.3/firebase-firestore.js";

const q = query(collection(db, "Users"));
let eval_page = document.getElementById("studentEvals");

const querySnapshot = await getDocs(q);
querySnapshot.forEach((doc) => {
  // doc.data() is never undefined for query doc snapshots
  console.log(doc.id, " => ", doc.data());

  // print users
  let data = doc.data();
  let firstName = data.firstName
  let lastName = data.lastName
  let email = data.email

    let section = document.createElement("section");
    section.className = 'collapsible'

    section.innerHTML = `<p>${firstName} ${lastName} (${email})</p>`;

});

var coll = document.getElementsByClassName("collapsible");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var content = this.nextElementSibling;
    if (content.style.display === "block") {
      content.style.display = "none";
    } else {
      content.style.display = "block";
    }
  });
}
