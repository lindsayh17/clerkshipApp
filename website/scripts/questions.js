import { db } from "./firebase.js";
import { collection , addDoc} from "https://www.gstatic.com/firebasejs/10.12.3/firebase-firestore.js";

// Question form

let submit = document.getElementById("submitBtn");
submit.addEventListener('click', async  (e) => {
  e.preventDefault();
    await addDoc(collection(db, "Questions"), {
        question: document.getElementById("txtQuestion").value,
        answer: document.getElementById("txtAnswer").value,
    });
    
    alert("Question added!");
});