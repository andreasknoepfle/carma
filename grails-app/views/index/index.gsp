<!doctype html>
<html>
  <head>
    <meta name="layout" content="main"/>
    <title>Carmeq GmbH | Carmob | Projekt Carma</title>
  </head>

  <body>
    <auth:ifLoggedIn>
      <p>Sammle CARMA Punkte, indem du Reservierungen zurückgibst, die du nicht brauchst.</p>
      
      <h2>CARMA Topliste</h2>
      <table border="1">
        <tbody>
          <tr>
            <td>Peter</td>
            <td>105</td>
          </tr>
          <tr>
            <td>Hans</td>
            <td>103</td>
          </tr>
        </tbody>
      </table>
    </auth:ifLoggedIn>

    <auth:ifUnconfirmed>
      Um die Registrierung abzuschließen, bestätigen Sie Ihre E-Mail Adresse.
      <g:link action="reconfirm">Senden Sie mir bitte eine weitere Bestätigungsmail.</g:link>
    </auth:ifUnconfirmed>
  </body>
</html>
