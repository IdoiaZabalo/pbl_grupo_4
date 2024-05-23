<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <head>
      <title>Información de pacientes</title>
      <link rel="stylesheet" type="text/css" href="Taula.css"/>
	  <link rel="stylesheet" type="text/css" href="../css2/general2.css"/>
	  <link rel="stylesheet" type="text/css" href="../css2/tabs2.css"/>
	  <link rel="stylesheet" type="text/css" href="../css2/Tab 1 (inicio)2.css"/>
	  <link rel="stylesheet" type="text/css" href="../css2/Tab 2 (sobre nosotros)2.css"/>
	  <link rel="stylesheet" type="text/css" href="../css2/Tab 3 (GlaucoTech)2.css"/>
	  <link rel="stylesheet" type="text/css" href="../css2/Tab 4 (Preguntas Frecuentes)2.css"/>
	  <link rel="stylesheet" type="text/css" href="../css2/Tab 5 (contáctenos)2.css"/>
	  <link rel="stylesheet" type="text/css" href="../css2/Tab 6 (Opiniones)2.css"/>
	  <link rel="stylesheet" type="text/css" href="../css2/Tab 7 (inicio de sesión)2.css"/> 
    </head>
	
    <body>
      <!-- Menú de la página web -->
		<div>
		  <div class="container">
			<img src="imagenes/logo-removebg-preview (2).png" class="logo"/>
			<div class="tabs">
			  <a class="tablinks active" href="../Index.html" >Inicio</a>
			  <a class="tablinks" href="../SobreNosotros.html">Sobre Nosotros</a>
			  <a class="tablinks" href="../GlaucoTech.html">GlaucoTech</a>
			  <a class="tablinks" href="../PreguntasFrecuentes.html">Preguntas Frecuentes</a>
			  <a class="tablinks" href="../Contactenos.html">Contáctenos</a>
			  <a class="tablinks" href="../Opiniones.html">Opiniones de Clientes</a>
			  <a class="tablinks" href="../InicioSesion.html">Iniciar Sesion</a>
			</div>
		  </div>
		</div>

      <h2>Información de pacientes</h2>
      <table border="1">
        <tr>
          <th>Hospital</th>
          <th>ID Ordenador</th>
          <th>ID Paciente</th>
          <th>Edad</th>
          <th>Fecha de diagnóstico</th>
          <th>Diagnóstico</th>
          <th>Imagen</th>
          <th>Nota Adicional</th>
        </tr>
        <xsl:for-each select="patients/patient">
		<xsl:sort select="age"/>
          <tr>
            <td><xsl:value-of select="hospital"/></td>
            <td><xsl:value-of select="order_id"/></td>
            <td><xsl:value-of select="@id"/></td>
            <td><xsl:value-of select="age"/></td>
            <td><xsl:value-of select="diagnosis_date"/></td>
            <td><xsl:value-of select="diagnosis"/></td>
            <td><img src="{image}" class="small-image" alt="Patient Image"/></td>
            <td><xsl:value-of select="note"/></td>
          </tr>
        </xsl:for-each>
      </table>

      <!-- Footer de la página web -->
      <footer>
        <div class="redes-sociales">
          <a href="#"><img src="imagenes/facebook-icon.png" alt="Facebook"/></a>
          <a href="#"><img src="imagenes/twitter-icon.png" alt="Twitter"/></a>
          <a href="#"><img src="imagenes/instagram-icon.png" alt="Instagram"/></a>
          <a href="#"><img src="imagenes/tiktok_logo_icon.png" alt="TikTok"/></a>
        </div>
        <p>Derechos de autor © 2024 MedCore. Todos los derechos reservados.</p>
      </footer>
    </body>
  </html>
</xsl:template>

</xsl:stylesheet>
