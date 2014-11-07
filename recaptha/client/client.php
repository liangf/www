  <html>
    <body> <!-- the body tag is required or the CAPTCHA may not show on some browsers -->
      <!-- your HTML content -->

      <form method="post" action="http://www.877ink.com/liang/recaptha/server/verify.php">
        <?php
          require_once('recaptchalib.php');
          $publickey = "6Le_y_USAAAAAEgnyWCG0hg2lS3qo_yPtW-iBdF6"; // you got this from the signup page
          echo recaptcha_get_html($publickey);
        ?>
        <input type="submit" />
      </form>

      <!-- more of your HTML content -->
    </body>
  </html>