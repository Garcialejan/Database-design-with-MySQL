
# Código para generar 100000 usuarios con el objetivo de comprobar el funcionamiento de los índices

for i in range(10):
    values = ",\n".join([
        f'("Antonio", "antonio{j}@gmail.com", "1234")' 
        for j in range(10000 * i, 10000 * (i + 1))
    ])
    
    print (f"INSERT INTO users (id, email, password) VALUES {values};")