function openTab(evt, tabName) {
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }
  document.getElementById(tabName).style.display = "block";
  evt.currentTarget.className += " active";

  // Distribuir opiniones en dos columnas
  var opiniones = document.getElementsByClassName("opinion");
  var mitad = Math.ceil(opiniones.length / 2); // Calcula la mitad de opiniones
  for (i = 0; i < opiniones.length; i++) {
    if (i < mitad) {
      opiniones[i].classList.add("columna-izquierda");
      opiniones[i].classList.remove("columna-derecha");
    } else {
      opiniones[i].classList.add("columna-derecha");
      opiniones[i].classList.remove("columna-izquierda");
    }
  }
}
function toggleInfo(element) {
  // Toggling class to the clicked member
  element.classList.toggle("clicked");
  // Getting all other team members
  var teamMembers = document.querySelectorAll(".team-member");
  // Looping through all team members
  teamMembers.forEach(function (member) {
    // Checking if the current member is not the clicked one
    if (member !== element.parentElement) {
      // Removing the "clicked" class from other team members
      member.classList.remove("clicked");
    }
  });
}

document.addEventListener('DOMContentLoaded', function () {
  var formulario = document.getElementById('tu-formulario');
  var mensajeConfirmacion = document.getElementById('mensaje-confirmacion');

  formulario.addEventListener('submit', function (event) {
    event.preventDefault(); // Evitar el envío del formulario por defecto

    mensajeConfirmacion.style.display = 'block';

    setTimeout(function () {
      mensajeConfirmacion.style.display = 'none';
    }, 4000); //Para eliminar el mensaje en 4 segundos
  });
});


document.addEventListener("DOMContentLoaded", function() {
  var dialog = document.getElementById("dialog");
  var openDialogButton = document.getElementById("openDialogButton");
  var confirmButton = document.getElementById("confirmButton");
  var healthProfessionalCheckbox = document.getElementById("healthProfessionalCheckbox");

  openDialogButton.onclick = function() {
    dialog.style.display = "block";
  }

  confirmButton.onclick = function() {
    if (healthProfessionalCheckbox.checked) {
      window.location.href = "../INTERFAZ/GlaucoTech/for_redistribution_files_only/GlaucoTech.exe"; // Cambia este enlace al que desees
    } else {
      alert("Por favor, confirme que es un profesional de la salud.");
    }
    dialog.style.display = "none";
  }

  window.onclick = function(event) {
    if (event.target == dialog) {
      dialog.style.display = "none";
    }
  }
});
