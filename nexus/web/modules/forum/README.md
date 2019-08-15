**Notes from most recent phpBB updgrade from 3.1.10 to 3.2.7**

We followed the upgrade guide [here](https://www.phpbb.com/support/docs/en/3.2/ug/upgradeguide/upgrade31/)

Here are some specifics about steps we had to do in addition to or in explanation of the official upgrade guide. Read this side-by-side the official instructions.

0. Take forum features offline in Nexus Advantage using offline_placeholder where content is loaded

   - Public: forum tab
   - Advantage: forum tab, inbox tab, user profile avatar

    Also backup home directory

1. Under Board Settings, set prosilver as Default and Guest style

2. Under Customize > Styles, deactivate custom styles nexus and public

4. Rename the production /forum directory to /forum_bak

5. Make a new empty /forum directory

6. Copy from /forum_bak to /forum the files that are supposed to be preserved (config.php and other folders)

7. Prep the local installation package according to upgrade guide (remove config.php and other folders)

8. Copy the local installation package to new /forum folder according to upgrade guide. (Overwrite and merge according to upgrade guide.)

9. Copy to /forum our .htaccess file in /forum_bak (make sure you don't override any of the default settings in the stock .htaccess)

10. (Re)create soft links to our custom styles that live in the nexus codebase. See /forum_bak for example.

11. Reactivate custom styles nexus and public

12. Reset to our default styles in Board Settings

Final - Bring forum features back online in Nexus Advantage
