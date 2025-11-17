import { db } from "./firebase.js";
import { doc , getDoc, updateDoc} from "https://www.gstatic.com/firebasejs/10.12.3/firebase-firestore.js";

// User form
const params = new URLSearchParams(window.location.search);
const userID = params.get("id");

if(userID){
  const docRef = doc(db, "Users", userID);
  const docSnap = await getDoc(docRef);

  if (docSnap.exists()) {
    console.log("Document data:", docSnap.data());

    let data = docSnap.data();

    // Fill placeholder text
    let firstName = data.firstName;
    document.getElementById("txtFName").value = firstName;
    let lastName = data.lastName;
    document.getElementById("txtLName").value = lastName;
    let email = data.email;
    document.getElementById("txtEmail").value = email;
    
    let access = data.access;
    document.getElementById("accesslvl").value = access;


  } else {
    // docSnap.data() will be undefined in this case
    console.log("No such document!");
  }
}

let submit = document.getElementById("submitBtn");
submit.addEventListener('click', async  (e) => {
  e.preventDefault();
    const userRef = doc(db, 'Users', userID);
    await updateDoc(userRef, {
        firstName: document.getElementById("txtFName").value,
        lastName: document.getElementById("txtLName").value,
        email: document.getElementById("txtEmail").value,
        access: document.getElementById("accesslvl").value
    });
    
    alert("User updated!");
});