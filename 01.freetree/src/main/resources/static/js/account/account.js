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

function checkForm_m() {
    var memail = document.getElementById("memail").value;
    var mpw = document.getElementById("mpw").value;
    var mpw_check = document.getElementById("mpw_check").value;
    var mname = document.getElementById("mname").value;
    var mnick = document.getElementById("mnick").value;
    var mbirth = document.getElementById("mbirth").value;
    var mhp = document.getElementById("mhp").value;

    var membtn = document.getElementById("membtn");

    if (memail === '' || mpw === '' || mpw_check === '' || mname === '' || mnick === '' || mbirth === '' || mhp === '') {
        membtn.disabled = true;
    }else {
        membtn.disabled = false;
    }
}

function checkForm_c() {
    var ccomtype = document.getElementById("ccomtype").value;
    var cbiznum = document.getElementById("cbiznum").value;
    var cname = document.getElementById("cname").value;
    var cpostalcode = document.getElementById("cpostalcode").value;
    var croadaddr = document.getElementById("croadaddr").value;
    var croaddetail = document.getElementById("croaddetail").value;
    var caddr = document.getElementById("caddr").value;
    var ctel = document.getElementById("ctel").value;
    var cemail = document.getElementById("cemail").value;
    var cpw = document.getElementById("cpw").value;
    var cpw_check = document.getElementById("cpw_check").value;
    var chp = document.getElementById("chp").value;
    var cpersonnel = document.getElementById("cpersonnel").value;
    var cdelegate = document.getElementById("cdelegate").value;
    var combtn = document.getElementById("combtn");

    if (ccomtype === '' || cbiznum === '' || cname === '' || cpostalcode === '' || croadaddr === '' || croaddetail === '' || caddr === '' || ctel === '' || cemail === '' || cpw === '' || cpw_check === '' || chp === '' || cpersonnel === '' || cdelegate === '') {
        combtn.disabled = true;
    }else {
        combtn.disabled = false;
    }
}