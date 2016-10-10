Para realizar el aprovisionamiento es necesario a traves de la consola dirigirse a la carpeta que tiene el Vagrantfile, despues de esto se necesita digitar el comando:

vagrant up centos_database

Despues de haber terminado se procede a digitar el comando:

vagrant up centos_web_flask

Es necesario esperar un poco de tiempo con el fin de que las maquinas queden aprovisionadas.

Para acceder al servicio web de prueba que retorna el mensaje : " Hi!, I am a greedy algorithm" es necesario ingresar a la direccion:

http://192.168.0.13:5000/hi


Para acceder al servicio web que se conecta a la base de datos y realiza un select sobre la misma es necesario ingresar a la direccion:

http://192.168.0.13:5000/select
