Pasos para conectar con el repositorio:

// Copiar el repositorio a tu carpeta local
1. git clone https://github.com/Isroca23/Proyecto-safa.git

// Moverte a la carpeta del Proyecto
2. cd Proyecto-safa

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
4. git push


Pasos para abrir en local:

// Instalar npm
1. npm i

// Ejecutar local
2. npm run dev

Pasos para actualizar tailwind:

// Build de tailwindailwi
1. npx tailwind -i ./src/input.css -o ./src/output.css --watch