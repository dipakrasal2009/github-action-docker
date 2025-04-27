from flask import Flask

app = Flask(__name__)

@app.route("/")
def main():
    return "Hello, task completed successfully...............!\n"

app.run(host="0.0.0.0")
