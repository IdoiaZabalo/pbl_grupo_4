<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <head>
      <title>Información de pacientes</title>
      <link rel="stylesheet" type="text/css" href="Taula.css"/>
    </head>
    <body>
      <!-- Menú de la página web -->
      <div class="container">
        <img src="imagenes/logo-removebg-preview (2).png" class="logo"/>
        <div class="tabs">
          <button class="tablinks" onclick="openTab(event, 'Tab1')">Inicio</button>
          <button class="tablinks" onclick="openTab(event, 'Tab2')">Sobre Nosotros</button>
          <button class="tablinks" onclick="openTab(event, 'Tab3')">GlaucoTech</button>
          <button class="tablinks" onclick="openTab(event, 'Tab4')">Preguntas Frecuentes</button>
          <button class="tablinks" onclick="openTab(event, 'Tab5')">Contáctenos</button>
          <button class="tablinks" onclick="openTab(event, 'Tab6')">Opiniones de Clientes</button>
          <button class="tablinks" onclick="openTab(event, 'Tab7')">Iniciar Sesion</button>
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
