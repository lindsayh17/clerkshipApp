import { db } from "./firebase.js";
import { doc, getDoc, collection, query, where, getDocs } from "https://www.gstatic.com/firebasejs/10.12.3/firebase-firestore.js";

const q = query(collection(db, "Users"), where("access", "==", "student"));
let eval_page = document.getElementById("studentEvals");

// Print list of users as collapsible sections
const querySnapshot = await getDocs(q);
querySnapshot.forEach(async (userDoc) => {
  // doc.data() is never undefined for query doc snapshots
  console.log(userDoc.id, " => ", userDoc.data());

  // print users
  let data = userDoc.data();
  let firstName = data.firstName
  let lastName = data.lastName
  let email = data.email

  let section = document.createElement("section");
  section.className = 'collapsible';
  eval_page.appendChild(section);

  section.innerHTML = `<p>${firstName} ${lastName} (${email})</p>`;

  let collapseContent = document.createElement("section");
  collapseContent.className = 'content';
  eval_page.appendChild(collapseContent);

  // list of evaluations
  const evals = query(collection(db, "Evaluations"), where("studentId", "==", data.id))
  const evalsQuerySnapshot = await getDocs(evals);
  if(evalsQuerySnapshot.empty){
    let noEval = document.createElement("p");
    collapseContent.appendChild(noEval);
    noEval.innerHTML ="No current evaluations";
  }
  evalsQuerySnapshot.forEach(async (evalsDoc) => {
    let evalData = evalsDoc.data();
    let timestamp = evalData.submittedAt;
    let date = timestamp.toDate().toDateString();
    let type = evalData.formType;

    const preceptorRef = doc(db, "Users", evalData.preceptorId);
    const preceptorSnap = await getDoc(preceptorRef);
    if(preceptorSnap.exists()){
      let preceptorData = preceptorSnap.data();
      let firstName = preceptorData.firstName;
      let lastName = preceptorData.lastName;
      let email = preceptorData.email;

      let link = document.createElement("a");
      collapseContent.appendChild(link);
      link.href = `evalView.php?id=${evalsDoc.id}&stuFN=${data.firstName}&stuLN=${data.lastName}&stuE=${data.email}`;

      let evalLink = document.createElement("section");
      link.appendChild(evalLink);

      let evalLinkTxt = document.createElement("p");
      evalLink.appendChild(evalLinkTxt);
      evalLinkTxt.innerHTML =`${type}: ${date}  -  ${firstName} ${lastName} (${email})`;
      
    }
  });
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

// Evaluations for each User