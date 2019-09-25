**Resources**

https://lingohub.com/blog/2013/07/php-internationalization-with-gettext-tutorial/

https://blog.udemy.com/php-gettext/


**How to manage translations**

We manage our translations at https://translate.lingohub.com

The basic workflow is like this:

When language translations are updated, download the .po file for that language and store it at 

`*/LC_MESSAGES`

Compile it to .mo with this command (example)

`msgfmt messages.ta.po -o messages.mo`

Move the .mo file to deployment folder


**To add a new language**

Touch points are at

nwmFrame.php (language select options)  
Util.php: add to $supportedLangs  
check that language is configured on hosting machine as explained in Util.php setUserLanguageEnv()


