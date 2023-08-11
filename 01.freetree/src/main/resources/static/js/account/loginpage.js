function showPersonalForm() {
    document.getElementById("personalForm").style.display = "block";
    document.getElementById("corporateForm").style.display = "none";
    document.getElementById("personal").style.backgroundColor = "#fff";
    document.getElementById("personal").style.color = "#1DB088";
    document.getElementById("corporate").style.backgroundColor = "#fff";
    document.getElementById("corporate").style.color = "#ccc";
}

function showCorporateForm() {
    document.getElementById("personalForm").style.display = "none";
    document.getElementById("corporateForm").style.display = "block";
    document.getElementById("personal").style.backgroundColor = "#fff";
    document.getElementById("personal").style.color = "#ccc";
    document.getElementById("corporate").style.backgroundColor = "#fff";
    document.getElementById("corporate").style.color = "#1DB088";
}
            

 