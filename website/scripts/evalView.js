import { db } from "./firebase.js";
import { doc , getDoc, updateDoc} from "https://www.gstatic.com/firebasejs/10.12.3/firebase-firestore.js";

// Eval Display
const params = new URLSearchParams(window.location.search);
const evalID = params.get("id");
const firstName = params.get("stuFN");
const lastName = params.get("stuLN");
const email = params.get("stuE");

// get main
let main = document.getElementById("evalView");

if(evalID){
    // Get evaluation
    const docRef = doc(db, "Evaluations", evalID);
    const docSnap = await getDoc(docRef);
    
    if (docSnap.exists()) {
        console.log("Document data:", docSnap.data());

        let data = docSnap.data();

        let type = data.formType;
        let responses = data.responses;
        let header = document.createElement("h2");
        header.innerHTML = `${type} Evaluation: ${firstName} ${lastName} (${email})`;
        main.appendChild(header);

        for (const [category, questions] of Object.entries(responses)) {

            let section = document.createElement("section");
            section.className = "category";

            let h3 = document.createElement("h3");
            h3.textContent = category;
            section.appendChild(h3);

            for (const [question, answer] of Object.entries(questions)) {
                let sec = document.createElement("section");
                sec.className = "qa";

                sec.innerHTML = `
                    <p class="question">${question}</p>
                    <p class="answer">${answer}</p>
                `;

                section.appendChild(sec);
            }

            main.append(section);
        }
        
        let notes = data.notes;
        let note = document.createElement("section")
        note.className = "notes";
        note.innerHTML = `<h3>Notes:</h3><p>${notes}</p>`;
        main.append(note);
    }
}else{
    let p = document.createElement("p");
    p.textContent = "Error loading evaluation. Please try again later.";
    main.appendChild(p);
}