Pasos para conectar con el repositorio:

// Copiar el repositorio a tu carpeta local
1. git clone https://github.com/andressanabriat/Dynamic.git

// Moverte a la carpeta del Proyecto
2. cd Flutter Entreno

// Entrar a tu rama de trabajo
3. git checkout nombredelarama

// Actualizar los archivos
4. git pull origin main


Pasos para hacer un commit:

// Identificarte
1. git config --global user.name Tunombre

// Añadir todos los archivos
2. git add .

// Crear el commit
3. git commit -m "mensaje_del_commit"

// Hacer el push
4. git push nombredelarama


Si no te deja hacer el pull:
// con esto guardas los cambios que tengas
1. git stash 

2. git pull origin main

// nos devuelve los cambios que hemos guardado anteriormente
3. git stash apply