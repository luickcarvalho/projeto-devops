from flask import Flask, jsonify, request
import mysql.connector
import os

MYSQL_HOST = os.environ["mysql_host"]
MYSQL_DB = os.environ["mysql_db"]
MYSQL_USER = os.environ["mysql_user"]
MYSQL_PASS = os.environ["mysql_pass"]

app_name = 'comentarios'
app = Flask(app_name)
app.debug = True

# Configurações do banco de dados
db_config = {
    'host':{MYSQL_HOST},
    'user': {MYSQL_USER},
    'password': {MYSQL_PASS},
    'database': {MYSQL_DB}
}

# Conectar ao banco de dados
conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()

# Criar tabela se não existir
cursor.execute("""
CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255),
    comment TEXT,
    content_id INT
)
""")

# Rota para adicionar um novo comentário
@app.route('/api/comment/new', methods=['POST'])
def api_comment_new():
    request_data = request.get_json()

    if request_data is None:
        return jsonify({'error': 'No JSON data received'}), 400

    email = request_data.get('email')
    comment = request_data.get('comment')
    content_id = request_data.get('content_id')

    if email is None or comment is None or content_id is None:
        return jsonify({'error': 'Incomplete data received'}), 400

    # Inserir o comentário no banco de dados
    query = "INSERT INTO comments (email, comment, content_id) VALUES (%s, %s, %s)"
    cursor.execute(query, (email, comment, content_id))
    conn.commit()

    message = 'Comment created and associated with content_id {}'.format(content_id)
    response = {
        'status': 'SUCCESS',
        'message': message,
    }
    return jsonify(response)


# Rota para listar os comentários de um determinado content_id
@app.route('/api/comment/list/<content_id>')
def api_comment_list(content_id):
    # Recuperar os comentários do banco de dados
    query = "SELECT email, comment FROM comments WHERE content_id = %s"
    cursor.execute(query, (content_id,))
    comments = cursor.fetchall()

    if comments:
        # Converter os resultados para um formato JSON
        comments_json = [{'email': row[0], 'comment': row[1]} for row in comments]
        return jsonify(comments_json)
    else:
        message = 'content_id {} not found'.format(content_id)
        response = {
            'status': 'NOT-FOUND',
            'message': message,
        }
        return jsonify(response), 404

# Rota de health check
@app.route('/healthcheck')
def healthcheck():
    return 'OK'

### Executar a aplicação Flask
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
