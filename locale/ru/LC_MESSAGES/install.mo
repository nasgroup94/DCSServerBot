��    C      4  Y   L      �  6   �     �     �  	     R       i  8   ~  $   �  $  �  �   
  �   �
  [  F     �     �     �     �  #   �  (        6     T  1   s     �     �  9   �  &     2   <  @   o  1   �  .   �  *        <  *   P  :   {     �     �      �  ,        3  2   9  <   l  3   �  4   �  R     Y   e  M   �  <     3   J  &   ~  �   �  :   H  ?   �  �   �  )   r  B   �  G   �  ?   '  8   g  /   �  S   �  0   $  6   U  [   �  "   �  6     "   B  
   e     p  u   �  !   f     �     �  �   �  9  :  o   t  6   �  K    e  g  �   �  �  �   0   �"      �"      #     ##  ?   5#  B   u#  <   �#  ;   �#  O   1$  '   �$     �$  R   �$  C   %  l   _%  v   �%  b   C&  P   �&  G   �&  5   ?'  ;   u'  V   �'  &   (  #   /(  3   S(  p   �(     �(  T   )  i   Z)  Z   �)  e   *  z   �*  �    +  {   �+  |   ,  Y   ,  S   �,  >  --  h   l.  e   �.  -  ;/  B   i0  �   �0  �   _1  h   )2  m   �2  M    3  �   N3  }   �3  ?   Y4  �   �4  G   E5  q   �5  C   �5     C6         )      >       9       8          ;   5   	   %          +   $   /       ,               !                    3      #      C      :      6   (          *       A         B       2      '          @       &      7   <         -   ?       "          
                     0       4   =                         1      .    

All set. Writing / updating your config files now... 
1. General Setup 
2. Discord Setup 
Aborted. 
DCS server "{}" found.
Would you like to manage this server through DCSServerBot? 
For a successful installation, you need to fulfill the following prerequisites:

    1. Installation of PostgreSQL from https://www.enterprisedb.com/downloads/postgres-postgresql-downloads
    2. A Discord TOKEN for your bot from https://discord.com/developers/applications

 
Please provide a channel ID for audit events (optional) 
Searching for DCS installations ... 
The Status Channel should be readable by everyone and only writable by the bot.
The Chat Channel should be readable and writable by everyone.
The Admin channel - central or not - should only be readable and writable by Admin and DCS Admin users.

You can create these channels now, as I will ask for the IDs in a bit.
DCSServerBot needs the following permissions on them to work:

    - View Channel
    - Send Messages
    - Read Messages
    - Read Message History
    - Add Reactions
    - Attach Files
    - Embed Links
    - Manage Messages

 
The bot can either use a dedicated admin channel for each server or a central admin channel for all servers.
If you want to use a central one, please provide the ID (optional) 
We now need to setup your Discord roles and channels.
DCSServerBot creates a role mapping for your bot users. It has the following internal roles: 
[green]Your basic DCSServerBot configuration is finished.[/]

You can now review the created configuration files below your config folder of your DCSServerBot-installation.
There is much more to explore and to configure, so please don't forget to have a look at the documentation!

You can start DCSServerBot with:

    [bright_black]run.cmd[/]

 
{}. DCS Server Setup 
{}. Database Setup 
{}. Node Setup - Created {} Aborted: No DCS installation found. Aborted: No valid Database URL provided. Aborted: configuration exists Aborted: missing requirements. Adding instance {instance} with server {name} ... DCS-SRS installation path: {} DCS-SRS not configured. DCSServerBot uses up to {} channels per supported server: Directory not found. Please try again. Do you want DCSServerBot to autostart this server? Do you want your DCS installation being auto-updated by the bot? Do you want your DCSServerBot being auto-updated? Enter the hostname of your PostgreSQL-database Enter the port to your PostgreSQL-database For admin commands. Have you fulfilled all these requirements? I've found multiple installations of DCS World on this PC: Installation finished. Instance {} configured. No configured DCS servers found. Normal user, can pull statistics, ATIS, etc. Other Please enter the ID of your [bold]Admin Channel[/] Please enter the ID of your [bold]Chat Channel[/] (optional) Please enter the ID of your [bold]Status Channel[/] Please enter the path to your DCS World installation Please enter the path to your DCS-SRS installation.
Press ENTER, if there is none. Please enter your Discord Guild ID (right click on your Discord server, "Copy Server ID") Please enter your Owner ID (right click on your discord user, "Copy User ID") Please enter your PostgreSQL master password (user=postgres) Please enter your discord TOKEN (see documentation) Please enter your password for user {} Please separate roles by comma, if you want to provide more than one.
You can keep the defaults, if unsure and create the respective roles in your Discord server. Please specify, which installation you want the bot to use SRS configuration could not be created, manual setup necessary. The bot can be set to the same language, which means, that all Discord and in-game messages will be in your language as well. Would you like me to configure the bot this way? To display the mission and player status. Users can delete data, change the bot, run commands on your server Users can upload missions, start/stop DCS servers, kick/ban users, etc. Which role(s) in your discord should hold the [bold]{}[/] role? [bright_black]Optional:[/]: An in-game chat replication. [green]- Database user and database created.[/] [red]A configuration for this nodes exists already![/]
Do you want to overwrite it? [red]Master password wrong. Please try again.[/] [red]No PostgreSQL-database found on {host}:{port}![/] [red]SRS configuration could not be created.
Please copy your server.cfg to {} manually.[/] [red]Wrong password! Try again.[/] [yellow]Configuration found, adding another node...[/] [yellow]Existing {} user found![/] {} written Project-Id-Version: 1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Language: ru
 

Все настроено. Записываем / обновляем конфигурационные файлы... 
1. Общая настройка 
2. Настройка Discord 
Отмена. 
DCS сервер "{}" найден.
Вы хотите управлять этим сервером с помощью DCSServerBot? 
Для успешной установки Вам потребуется следующее:

    1. Установленная СУБД PostgreSQL https://www.enterprisedb.com/downloads/postgres-postgresql-downloads
    2. Discord-TOKEN для Вашего бота https://discord.com/developers/applications

 
Пожалуйста укажите канал для сообщений аудита (опционально) 
Поиск установленного DCS World ... 
Канал статуса должен быть доступен всем на чтение и на запись боту.
Канал чата должен быть доступен на чтение и на запись всем.
Административные каналы - общий или отдельные - должны быть доступны на чтение и запись только ролям Admin и DCS Admin.

Вы можете создать каналы сейчас, их ID нужно будет ввести чуть позже.
DCSServerBot для работы требуются следующие разрешения для каналов:

    - View Channel
    - Send Messages
    - Read Messages
    - Read Message History
    - Add Reactions
    - Attach Files
    - Embed Links
    - Manage Messages

 
Бот может использовать выделенные административные каналы для каждого сервера или общий админ-канал для всех серверов сразу.
Если вы хотите использовать общий канал, укажите его ID (опционально) 
Теперь необходимо настроить Discord роли и каналы.
DCSServerBot создаёт маппинг ролей для пользователей бота. Доступны следующие внутренние роли: 
[green]Базовая конфигурация DCSServerBot выполнена.[/]

Вы можете проверить созданную конфигурацию в папке config вашей установки DCSServerBot.
Бот содержит множество настроек, поэтому не забудьте ознакомиться с документацией!

Для запуска DCSServerBot используйте файл:

    [bright_black]run.cmd[/]

 
{}. Конфигурация DCS сервера 
{}. Настройка СУБД 
{}. Настройка ноды - {} Создан Отмена: Не найдена установка DCS World. Отмена: Не указан правильный СУБД URL. Отмена: конфигурация существует. Отмена. Требования не выполнены. Добавление инстанса {instance} с сервером {name} ... Путь установки DCS-SRS: {} DCS-SRS не настроен. DCSServerBot использует {} Discord-каналов на DCS сервер: Папка не найдена. Попробуйте ещё раз. Вы хотите чтобы DCSServerBot автоматически запускал этот сервер? Вы хотите чтобы бот автоматически обновлял вашу установку DCS World? Вы хотите включить автоматическое обновление DCSServerBot? Введите имя хоста вашего СУБД-сервера PostgreSQL Введите порт вашего СУБД-сервера PostgreSQL Для административных команд. Вы выполнили все эти требования? Найдено несколько установок DCS World на данном ПК: Установка завершена. Инстанс {} настроен. Нет настроенных DCS серверов. Обычный пользователь, может запрашивать статистику, ATIS, и т.д. Прочее Пожалуйста введите ID вашего [bold]админ-канала[/] Пожалуйста введите ID вашего [bold]чат-канала[/] (опционально) Пожалуйста введите ID вашего [bold]статус-канала[/] ein Пожалуйства введите путь до папки, где установлен DCS World Введите путь до установки DCS-SRS.
Нажмите ENTER, если DCS-SRS не установлен. Пожалуйста введите ваш Discord Guild ID (правый щелчок по Discord-серверу, "Copy Server ID") Пожалуйста введите ваш Owner ID (правый щелчок по Discord-серверу, "Copy User ID") Введите мастер-пароль вашего СУБД-сервера PostgreSQL (пользователь=postgres) Пожалуйста введите ваш Discord TOKEN (см. документацию) Пожалуйста введите пароль для пользователя {} Пожалуйста, при указании более одной роли, разделяйте их запятой.
Вы можете оставить значения по умолчанию если не уверены и создать необходимые роли на сервере Discord вручную. Пожалуйста укажите, какую установку DCS использовать боту SRS-конфигурация не создана, требуется ручная настройка. Бот может быть настроен на ваш родной язык, что означает что все игровые и Discord сообщения будут показываться на вашем языке. Вы хотите использовать локализацию бота? Для показа статуса миссии и игроков. Пользователи могут удалять данные, изменять настройки бота и выполнять команды на вашем сервере. Пользователи могут заливать миссии, запускать и останавливать DCS серверы, кикать и банить пользователей и т.д. Какие роли на вашем Discord серверы должны быть [bold]{}[/] ролью? [bright_black]Опционально:[/]: Канал с репликацией игрового DCS чата. [green]- Пользователь и база данных созданы.[/] [red]Конфигурация для данной ноды уже существует!![/]
Вы хотите перезаписать её? [red]Неправильный пароль для пользователя "postgres". Попробуйте ещё раз.[/] [red]Не найдена БД PostgreSQL на {host}:{port}![/] [red]Не получилось создать SRS-конфигурацию.
Пожалуйста скопируйте файл server.cfg в папу {} вручную.[/] [red]Неверный пароль! Попробуйте снова.[/] [yellow]Конфигурация найдена, добавление дополнительной ноды...[/] [yellow]Пользователь {} уже существует![/] {} записан 