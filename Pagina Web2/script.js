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

    // Aquí podrías agregar el código para enviar el formulario por AJAX o cualquier otro método

    // Mostrar el mensaje de confirmación
    mensajeConfirmacion.style.display = 'block';

    // Ocultar el mensaje de confirmación después de 6 segundos
    setTimeout(function () {
      mensajeConfirmacion.style.display = 'none';
    }, 4000);
  });
});


