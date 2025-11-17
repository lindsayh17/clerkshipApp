// Import the functions you need from the SDKs you need
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.12.3/firebase-app.js";
import { getFirestore } from "https://www.gstatic.com/firebasejs/10.12.3/firebase-firestore.js";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDwHpKodUJ0v7jjJG2C5WV9Gx841N2Zvj8",
  authDomain: "obgyn-clerkship.firebaseapp.com",
  projectId: "obgyn-clerkship",
  storageBucket: "obgyn-clerkship.firebasestorage.app",
  messagingSenderId: "543826125835",
  appId: "1:543826125835:web:4b28decf46e2e320ce530e",
  measurementId: "G-3J35ZVNL6M"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize cloud firestore
const db = getFirestore(app);

export{db, app};